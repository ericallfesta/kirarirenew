class Admin::RequestProductsController < AdminController
  before_action :set_request_product, except: :index

  def index
    @request_products = RequestProduct.page params[:page]
  end

  def edit
  end

  def update
    if @request_product.update(permit_params)
      redirect_to admin_request_products_url, notice: '商品登録依頼を修正しました'
    else
      render action: 'edit'
    end
  end

  def destroy
    @request_product.delete
    redirect_to admin_request_products_url
  end

  private

  def permit_params
    params.require(:request_product).permit(:status)
  end

  def set_request_product
    @request_product = RequestProduct.find(params[:id])
  end
end
