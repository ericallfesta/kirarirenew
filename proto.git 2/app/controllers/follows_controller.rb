class FollowsController < ApplicationController
  before_action :require_login, except: [:index]
  after_action :meta_noindex

  def index
    user_id = params[:user_id] if params.has_key? :user_id
    user_id ||= current_user.id if logged_in?
    redirect_to login_path if user_id.nil?
    @follows = Follow.where( user_id: user_id )
  end

  def followers
    @target = User.find(params[:user_id]) if params.has_key? :user_id
    @followers = @target.followers
  end

  def following
    @target = User.find(params[:user_id]) if params.has_key? :user_id
    @following = @target.followed_users + @target.followed_brands
  end

  def create
    attributes = { followable_type: 'User', followable_id: params[:user_id] } if params.has_key? :user_id
    attributes = { followable_type: 'Brand', followable_id: params[:brand_id] } if params.has_key? :brand_id
    attributes[:user_id] = current_user.id
    @follow = Follow.new(attributes)

    respond_to do |format|
      if @follow.save
        format.json { render action: 'show', status: :created }
      else
        format.json { render json: @follow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @follow = Follow.where( user_id: current_user.id, followable_type: 'User', followable_id: params[:user_id]).first if params.has_key? :user_id
    @follow = Follow.where( user_id: current_user.id, followable_type: 'Brand', followable_id: params[:brand_id]).first if params.has_key? :brand_id
    @follow.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
