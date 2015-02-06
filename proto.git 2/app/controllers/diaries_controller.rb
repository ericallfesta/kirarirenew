class DiariesController < ApplicationController
  before_filter :require_login, only: %w[new create edit update destroy]
  before_filter :refuse_guest, only: %w[new create edit update destroy]
  before_filter :set_diary, only: %w[edit update destroy]
  before_filter :meta_noindex, only: %w[new edit]

  def redirect
    @diary = Diary.find params[:id]
    redirect_to @diary
  end

  def show
    @diary = Diary.find params[:id]

    check_notification(@diary)
    @diary.comments.each { |c| check_notification(c) }
    @meta = @diary.to_meta

    @next = @diary.next_diary
    @prev = @diary.prev_diary
  end

  def new
    @diary = Diary.new
    @diary.build_images
  end

  def edit
    @diary.build_images
  end

  def create
    @diary = Diary.new permitted_params.except(:images_attributes)
    @diary.writer = current_user

    if @diary.save
      # accepts_nested_attributes_for が new, create 時に正しく動作しないため
      @diary.update(permitted_params)
      redirect_to @diary, notice: '日記を登録しました。'
    else
      @diary.build_images
      render :new
    end
  end

  def update
    if @diary.update permitted_params
      redirect_to @diary
    else
      @diary.build_images
      render :edit
    end
  end

  def destroy
    @diary.destroy
    redirect_to current_user
  end

  protected

  def permitted_params
    params.require(:diary).permit(:title, :body, :range, images_attributes: [:id, :src, :src_cache, :_destroy])
  end

  def set_diary
    @diary = Diary.find params[:id]
  end
end
