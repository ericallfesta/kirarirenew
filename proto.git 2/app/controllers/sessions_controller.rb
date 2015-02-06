class SessionsController < ApplicationController
  before_filter :require_login, only: :destroy
  skip_before_filter :require_login_on_alpha

  def new
    redirect_to root_url if current_user
  end

  def create
    if @user = login(params[:email], params[:password], true)
      redirect_back_or_to root_url, notice: t('messages.success_to_login')
    else
      flash.now.notice = t('messages.failure_to_login')
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: t('messages.logged_out')
  end
end
