class Admin::BrandsController < AdminController
  before_action :set_brand, only: [:show, :edit, :update, :destroy]

  def index
    @brands = Brand.page(params[:page]).per(25)
  end

  def show
  end

  def new
    @brand = Brand.new
  end

  def edit
  end

  def create
    @brand = Brand.new brand_params

    if @brand.save
      redirect_to admin_brand_path(@brand), notice: 'ブランドを新規登録しました'
    else
      render action: 'new'
    end
  end

  def update
    if @brand.update brand_params
      redirect_to admin_brand_path(@brand), notice: 'ブランドを編集しました'
    else
      render action: 'edit'
    end
  end

  private

  def set_brand
    @brand = Brand.find(params[:id])
  end

  def brand_params
    params.require(:brand).permit :name, :kana, :display_kana, :description, :website, :hero_image, :remove_hero_image, :hero_image_cache, :image, :remove_image, :image_cache
  end
end
