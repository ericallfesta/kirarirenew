class NotificationsController < ApplicationController
  before_action :require_login

  def index
    Notification.all_read(current_user)
    @notifications = Notification.weekly(user: current_user)
  end
end
