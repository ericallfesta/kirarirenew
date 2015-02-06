class RequestProductsController < ApplicationController
  def create
    @request = RequestProduct.new permit_params.merge({ user: current_user})

    if @request.save
      redirect_to :root, notice: '商品登録依頼を受け付けました！'
    else
      redirect_to new_report_url, notice: '入力情報が不足しているため、商品登録依頼を受け付けられませんでした。'
    end
  end

  private

  def permit_params
    params.require(:request_product).permit(:name, :brand, :product_url, :brand_url)
  end
end
