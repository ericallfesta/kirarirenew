class Admin::VariationsController < AdminController
  before_action :set_product, only: [:new, :create]
  before_action :set_variation, only: [:edit, :update, :destroy]

  def new
    @variation = @product.variations.build
  end

  def edit
  end

  def create
    @variation = @product.variations.build permit_params

    if @variation.save
      redirect_to admin_product_url(@product), notice: "#{@product.name}のバリエーションを追加しました"
    else
      render :new
    end
  end

  def update
    if @variation.update permit_params
      redirect_to admin_product_url(@variation.product), notice: "#{@variation.product.name}のバリエーションを編集しました"
    else
      render :edit
    end
  end

  def destroy
    product = @variation.product
    @variation.destroy
    redirect_to admin_product_url(product), notice: "#{product.name}のバリエーションを削除しました"
  end

  private

  def set_product
    @product = Product.find params[:product_id]
  end

  def set_variation
    @variation = ProductVariation.find params[:id]
  end

  def permit_params
    params.require(:product_variation).permit :name, :price, :price_note, :image, :remove_image, :note, :ingredient, :website
  end
end
