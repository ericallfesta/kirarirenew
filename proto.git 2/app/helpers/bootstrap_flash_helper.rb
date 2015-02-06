module BootstrapFlashHelper
  ALERT_TYPES = [:danger, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, messages|
      next if messages.blank?

      type = :info if type == :notice
      type = :danger  if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(messages).each do |message|
        text = content_tag(:div, message.html_safe, class: "alert fade in alert-#{type}")
        flash_messages << text if message
      end
    end
    flash_messages.join("\n").html_safe
  end
end
