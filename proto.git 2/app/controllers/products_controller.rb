class ProductsController < ApplicationController
  include Fav

  before_action :set_product, only: :show
  before_action :count_access, only: :show

  def index
    respond_to do |format|
      format.json do
        render json: Product.published.search(build_conditions).limit(5)
      end
    end
  end

  def show
    @reports = @product.reports.limit(5)
    @questions = @product.questions.limit(5)

    @report = @product.reports.build
    @report.build_images
    @report.build_evaluations
    @report.build_detail
    @question = @product.questions.build
    @question.build_images

    @product.access_ranking.incr
    @meta = @product.to_meta

    gon.product = {}
    gon.product[:default] = @product
    gon.product[:variations] = @product.variations.inject({}) {|r, v| r[v.id] = v; r }
  end

  private

  def set_fav_target
    @fav_target = Product.published.find params[:id]
  end

  def set_product
    if logged_in? && current_user.is_enterprise?
      @product = current_user.brand.products.find params[:id]
    else
      @product = Product.published.find params[:id]
    end
  end

  def count_access
    @product.access!
  end

  def search_params
    params.require(:search).permit(:brand, :category, :tag)
  end

  # Product#search を整理して、Model側に処理を逃がす
  def build_conditions
    conditions = {}
    if search_params[:brand].present?
      conditions[:brand] = search_params[:brand].to_i
    end
    if search_params[:category].present? && category = TagGroup.category.tags.find_by_id(search_params[:category])
      conditions[:tags] = [category] + category.recursive_children_tags
    end
    if search_params[:tag].present? && tag = Tag.find_by_id(search_params[:tag])
      conditions[:tags] = [] if conditions[:tags].blank?
      conditions[:tags] << tag
    end
    conditions
  end
end
