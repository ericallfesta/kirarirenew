module NotificationReader
  extend ActiveSupport::Concern

  def check_notification(noticeable)
    return unless logged_in?
    notifications = Notification.where({
      noticeable_type: noticeable.class.base_class.to_s,
      noticeable_id: noticeable.id,
      user: current_user})
    notifications.each { |n| n.update(status: :read) unless notifications.empty? }
  rescue => e
    logger.error e
  end
end
