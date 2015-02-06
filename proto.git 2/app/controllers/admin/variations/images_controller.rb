class Admin::Variations::ImagesController < AdminController
  before_action :set_product
  before_action :set_variation

  def new
    @image = @variation.images.build
  end

  def create
    @image = @variation.images.build permit_params

    if @image.save
      flash[:notice] = "#{@variation.product.name}のバリエーションに画像を追加しました"
    else
      flash[:alert] = '画像投稿に失敗しました'
    end

    redirect_to admin_product_url(@product)
  end

  def destroy
    image = ProductImage.find params[:id]
    image.destroy
    redirect_to admin_product_url(@product)
  end

  private

  def set_product
    @product = Product.find params[:product_id]
  end

  def set_variation
    @variation = ProductVariation.find params[:variation_id]
  end

  def permit_params
    params.require(:product_image).permit :variation_id, :src, :primary
  end
end
