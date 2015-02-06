class StampsController < ApplicationController
  before_action :require_login
  before_action :set_user

  def index
    @stamps = @user.stamps
    if Notification.where(user_id: @user.id, noticeable_type: 'UserStamp').count
      @stamps.each { |s| s.user_stamps.each { |us| check_notification(us) } }
    end
  end

  private

  def set_user
    @user = User.find params[:user_id]
  end
end
