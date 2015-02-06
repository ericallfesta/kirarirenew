class Admin::ProductsController < AdminController
  before_action :set_brand, only: [:index, :new, :create]
  before_action :set_request_product, only: [:new, :create]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = @brand.products.except(:order).order(star: :desc, created_at: :asc)
    @products = @products.page params[:page] unless params[:paginate] == '0'
  end

  def show
  end

  def new
    @product = @brand.present? ? @brand.products.build : Product.new({ name: @request_product.name })
    set_categories
  end

  def edit
    set_categories
  end

  def create
    if @brand.present?
      @product = @brand.products.build product_params.except(:tags)
    else
      @product = Product.new product_params.except(:tags)
    end
    @product.tags = parse_tags

    if @product.save
      if @request_product.present?
        @request_product.update status: 'registered', product: @product
        @request_product.send_mail_to_created_user
      end
      redirect_to admin_product_path(@product), notice: "#{@brand.name}の商品を追加しました"
    else
      set_categories
      render action: 'new'
    end
  end

  def update
    @product.attributes = product_params.except(:tags)
    @product.tags = parse_tags

    if @product.save
      redirect_to admin_product_path(@product), notice: "#{@product.brand.name}の商品を編集しました"
    else
      set_categories
      render action: 'edit'
    end
  end

  def destroy
    brand = @product.brand
    @product.delete
    redirect_to admin_brand_products_url(brand), notice: "#{brand.name}の商品を削除しました"
  end

  private
    def set_brand
      @brand = Brand.find_by id: params[:brand_id]
    end

    def set_request_product
      @request_product = RequestProduct.find_by id: params[:request_product_id]
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def set_categories
      @categories = {}
      @selected_categories = []
      @categories[:level1] = TagGroup.category.tags.where(parent_id: nil).pluck(:name, :id)
      @categories[:level2], @categories[:level3], @categories[:level4] = {}, {}, {}
      return if @product.category.blank?
      @selected_categories = (@product.category.parents + [@product.category]).uniq
      @selected_categories.each.with_index do |category, i|
        @categories[:"level#{i + 2}"] = category.children.pluck(:name, :id)
      end
    end

    def product_params
      params.require(:product).permit(:name, :kana, :slug, :tags, :description, :price, :price_note, :image, :remove_image, :image_cache, :maker_id, :brand_id, :ingredient, :state, :source_url)
    end

    def parse_tags
      tags = []
      params[:category].reverse_each do |k, v|
        if %w(level1 level2 level3 level4).include?(k) && v.present?
          tags = [Tag.find_by(id: v)]
          break
        end
      end

      tags += Tag.where(id: product_params[:tags].split(',').map(&:to_i)).uniq
      tags.uniq
    end
end
