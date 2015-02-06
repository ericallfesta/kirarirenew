class RequestsController < ApplicationController
  def create
    @request = Request.new permit_params.merge({ url: request.referer, ua: request.user_agent })

    if @request.save
      render :show, formats: :json
    end
  end

  protected
    def permit_params
      params.require(:request).permit(:body)
    end
end
