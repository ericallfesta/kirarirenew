class QuestionsController < ApplicationController
  before_filter :require_login, only: %w[new create edit update destroy]
  before_filter :refuse_guest, only: %w[new create edit update destroy]
  before_filter :set_question, only: %w[show redirect edit update destroy]
  before_filter :meta_noindex, only: %w[new edit]

  def redirect
    redirect_to @question
  end

  def show
    check_notification(@question)
    @question.comments.each { |c| check_notification(c) }
  end

  def new
    @question = Question.new product_id: params[:product_id]
    @question.build_images
  end

  def edit
  end

  def create
    @question = Question.new(creating_params.except(:images_attributes))
    @question.writer_id = @current_user.id

    if @question.save
      # accepts_nested_attributes_for が new, create 時に正しく動作しないため
      @question.update(creating_params)
      redirect_to @question
    else
      @question.build_images
      render :new
    end
  end

  def update
    return redirect_to root_path if @question.writer_id != @current_user.id

    if @question.update_attributes(updating_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    return redirect_to root_path if @question.writer_id != @current_user.id

    user = @question.writer
    @question.destroy
    redirect_to user
  end

  private

  def creating_params
    params.require(:question).permit(:body, :title, :star, :product_id, images_attributes: [:src])
  end

  def updating_params
    params.require(:question).permit(:body, :title, :star)
  end

  def set_question
    @question = Question.find params[:id]
    @meta = @question.to_meta
  end
end
