class BrandsController < ApplicationController
  include Fav

  before_action :set_brand, only: [:show]

  def index
    respond_to do |format|
      format.json {
        brands = params[:kana].present? ? Brand.where(["`kana` LIKE ?", "#{params[:kana]}%"]) : Brand.all
        render json: brands.order('`kana` IS NULL, kana').to_json(methods: :name_with_kana)
      }
    end
  end

  def show
    @products = @brand.products.published.order(star: :desc).page params[:page]
    add_breadcrumb @brand.name, '#'
  end

  private

  def set_brand
    @brand = Brand.find params[:id]
  end

  def set_fav_target
    @fav_target = Brand.find params[:id]
  end
end
