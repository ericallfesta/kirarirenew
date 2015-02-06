class Admin::UsersController < AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.page params[:page]
  end

  def show
  end

  def new
    @user = User.new
  end

  def reset_password
  end

  def update_password
    if current_user.update_attributes(user_params)
      redirect_to [:admin, current_user], notice: 'パスワードを変更しました。'
    else
      render action: :reset_password
    end
  end

  def create
    @user = User.new(user_params.merge(terms: '1', brand: Brand.find(user_params[:brand])))

    @user.invisible = true if @user.is_enterprise?

    if @user.save
      redirect_to admin_users_url, notice: 'ユーザ情報を編集しました'
    else
      render action: 'new'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:display_name, :email, :password, :password_confirmation, :gender, :brand, :image, :bio, :birthday, :range_policy, :role, :column_writer)
    end
end
