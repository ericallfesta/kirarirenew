module Noticeable
  extend ActiveSupport::Concern

  included do
    after_create :publish_notification

    def publish_notification
      Notification.publish delegate: self
    end

    def notification
      {
        body: I18n.t("messages.notifications.#{notification_translate}", self.notification_body_attributes),
        icon: self.notification_icon,
        url: self.notification_link
      }
    end

    def notification_body_attributes
      {}
    end

    def notification_link
    end

    def notification_icon
    end

    def notification_translate
      self.class.to_s.underscore
    end
  end
end
