class Admin::RequestsController < AdminController
  before_action :set_request, only: [:destroy]

  def index
    @requests = Request.order(created_at: :desc).page params[:page]
  end

  def destroy
    @request.delete
    redirect_to admin_requests_url, notice: '要望を削除しました'
  end

  private

  def set_request
    @request = Request.find params[:id]
  end
end
