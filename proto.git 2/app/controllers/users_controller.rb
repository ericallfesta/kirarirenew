class UsersController < ApplicationController
  include Fav

  before_action :set_user, only: [:show, :timeline]
  before_action :set_search_type, only: [:timeline]
  before_action :before_on_alpha, only: [:new, :create]
  skip_before_action :require_login_on_alpha, only: [:new, :create]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permit_params)

    if @user.save
      if login(permit_params[:email], permit_params[:password], true)
        redirect_back_or_to root_path, notice: t('messages.success_to_signup')
      else
        redirect_to login_path
      end
    else
      render action: 'new'
    end
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to root_path, notice: t('messages.success_to_signup')
    else
      not_authenticated
    end
  end

  private

  def set_user
    @user = User.find params[:id]
    @meta = @user.to_meta(index: false)
    raise ActiveRecord::RecordNotFound if @user.nil?
  end

  def set_fav_target
    @fav_target = User.find(params[:id])
  end

  def permit_params
    params.require(:user).permit(:gender, :display_name, :email, :password, :password_confirmation, :birthday, :terms)
  end

  def set_search_type
    @search_type = %w(writings reports questions diaries).include?(params[:search_type]) ? params[:search_type] : 'writings'
  end

  def before_on_alpha
    if ENV["KIRARI_VERSION"] == 'Alpha'
      session[:invitation_key] = params[:key] if params.has_key? :key
      @invitation = Invitation.where( key: session[:invitation_key] ).first
      head :forbidden if @invitation.nil? || ! @invitation.user.nil?
    end
  end
end
