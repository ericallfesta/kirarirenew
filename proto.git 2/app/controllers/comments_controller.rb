class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]
  before_action :refuse_guest, only: [:create, :destroy]

  def index
    target_id = params["#{params[:type]}_id"].to_i
    @comments = Comment.where(writing_id: target_id).page(params[:page].to_i)

    respond_to do |format|
      format.json { render :index }
      format.any { render :index } if params[:format].nil?
      format.any { head :not_found } unless params[:format].nil?
    end
  end

  def create
    @comment = current_user.comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        format.json { render :show }
        format.any { render :show } if params[:format].nil?
        format.any { redirect_to @comment.writing } unless params[:format].nil?
      else
        format.json { render json: { errors: @comment.errors.full_messages }, status: :bad_request }
        format.any { head :bad_request }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def parent_writing
    if params[:report_id]
      Report.find params[:report_id]
    elsif params[:question_id]
      Question.find params[:question_id]
    elsif params[:diary_id]
      Diary.find params[:diary_id]
    end
  end

  def comment_params
    params.require(:comment).permit(:body).merge({ writing: parent_writing })
  end
end
