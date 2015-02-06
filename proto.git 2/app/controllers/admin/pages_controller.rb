class Admin::PagesController < AdminController
  before_action :set_page, only: [:edit, :update]

  def index
    @pages = Page.page params[:page]
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new permit_params
    if @page.save
      redirect_to admin_pages_url, notice: '固定ページを追加しました'
    else
      render :new
    end
  end

  def update
    if @page.update permit_params
      redirect_to admin_pages_url, notice: '固定ページを編集しました'
    else
      render :edit
    end
  end

  private

  def set_page
    @page = Page.find params[:id]
  end

  def permit_params
    params.require('page').permit 'title', 'body', 'slug', 'priority'
  end
end
