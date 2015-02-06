class AppsController < ApplicationController
  skip_before_action :set_sidebar_features
  skip_before_action :set_sidebar_activities
  skip_before_action :set_sidebar_notifications

  def home
    @activities = current_user.activities.limit(10) if logged_in?
    @notifications = Notification.order(created_at: :desc).limit 3
    @features = Feature.where(active: true)
    @news = News.published.limit 3
  end
end
