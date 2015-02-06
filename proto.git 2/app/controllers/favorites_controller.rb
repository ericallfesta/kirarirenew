class FavoritesController < ApplicationController
  before_action :require_login
  before_action :set_favorable

  def create
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.favorable = @favorable

    if @favorite.save
      render json: { status: true, kirari: true, msg: I18n.t('views.kirari_button.done'), count: @favorable.favorites.count }, status: :created
    else
      render nothing: true
    end
  end

  def destroy
    favorite = Favorite.where( favorite: @favorable, user: current_user ).first
    pp favorite
    favorite.destroy

    render json: { status: true, kirari: false, msg: I18n.t('views.kirari_button.done'), count: @favorable.favorites.count }, status: :success
  end

  private

  def set_favorable
    @favorable = Product.published.find params[:product_id] if params.has_key? :product_id
    @favorable = Report.find params[:report_id] if params.has_key? :report_id
    @favorable = Diary.find params[:diary_id] if params.has_key? :diary_id
    @favorable = Question.find params[:question_id] if params.has_key? :question_id
    @favorable = Brand.find params[:brand_id] if params.has_key? :brand_id
    @favorable = User.find params[:user_id] if params.has_key? :user_id
  end
end
