class Admin::SessionsController < AdminController
  skip_filter :permit_admin

  def new
    redirect_to admin_root_url if current_user && current_user.is_admin?
  end

  def create
    @user = login(params[:email], params[:password], true)

    if @user.present? && @user.is_admin?
      redirect_to admin_root_url, notice: 'ログインに成功しました'
    else
      logout
      flash[:notice] = 'ログインIDかパスワードが違います'
      render :new
    end
  end
end
