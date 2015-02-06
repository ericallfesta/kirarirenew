class NewsController < ApplicationController
  def index
    @news = News.published.page params[:page]
  end

  def show
    @news = News.published.find params[:id]
  end
end
