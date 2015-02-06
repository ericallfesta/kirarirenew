class My::UsersController < MyController
  def index
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: t('messages.update_user_done')
    else
      render action: 'edit'
    end
  end

  def reset_password
  end

  def update_password
    user = User.authenticate(current_user.email, params[:user][:old_password])
    if user && current_user.update_attributes(password_params)
      redirect_to user_path(current_user), notice: t('messages.update_password_done')
    else
      current_user.errors.add(:old_password, t('activerecord.errors.invalid_value'))
      render action: :reset_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:display_name, :email, :image, :bio, :gender, :birthday)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
