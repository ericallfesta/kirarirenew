class Admin::PopularKeywordsController < AdminController
  before_action :set_popular_keyword, only: [:edit, :update, :destroy]

  def index
    @popular_keywords = PopularKeyword.unscoped.order(deleted: :asc, priority: :desc).page params[:page]
  end

  def new
    @popular_keyword = PopularKeyword.new
  end

  def edit
  end

  def create
    @popular_keyword = PopularKeyword.new permit_params

    if @popular_keyword.save
      redirect_to admin_popular_keywords_url
    else
      render :edit
    end
  end

  def update
    if @popular_keyword.update permit_params
      redirect_to admin_popular_keywords_url
    else
      render :edit
    end
  end

  def destroy
    @popular_keyword.destroy
    redirect_to admin_popular_keywords_url
  end

  private

  def set_popular_keyword
    @popular_keyword = PopularKeyword.unscoped.find params[:id]
  end

  def permit_params
    params.require(:popular_keyword).permit :word, :priority, :deleted
  end
end
