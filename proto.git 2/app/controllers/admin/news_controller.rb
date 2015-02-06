class Admin::NewsController < AdminController
  before_action :set_news, only: [:show, :edit, :update, :destroy]

  def index
    @news = News.page params[:page]
  end

  def show
  end

  def new
    @news = News.new
  end

  def edit
  end

  def create
    @news = News.new news_params
    @news.writer = current_user

    if @news.save
      redirect_to admin_news_index_path, notice: 'ニュースを追加しました'
    else
      render action: 'new'
    end
  end

  def update
    if @news.update news_params
      redirect_to admin_news_index_path, notice: 'ニュースを編集しました'
    else
      render action: 'edit'
    end
  end

  private
    def set_news
      @news = News.find(params[:id])
    end

    def news_params
      params.require(:news).permit :title, :body, :writer, :status, :image, :remove_image, :image_cache, :published_at
    end
end
