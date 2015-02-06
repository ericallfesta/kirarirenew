class Admin::Products::ImagesController < AdminController
  before_action :set_product

  def create
    @image = @product.images.build permit_params

    if @image.save
      flash[:notice] = "#{@product.name}に画像を追加しました"
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

  def permit_params
    params.require(:product_image).permit :src, :primary
  end
end
