class Favorite < ActiveRecord::Base
  include Noticeable

  belongs_to :user
  belongs_to :favorable, polymorphic: true

  validates_presence_of :user, :favorable

  before_save :check_duplicate
  after_create :get_send_kirari_for_diary_stamp

  def notification_body_attributes
    { name: user.display_name }
  end

  def notification_link
    return "/users/#{user.id}" if favorable.is_a? User
    "/#{favorable.class.to_s.pluralize.downcase}/#{favorable.id}"
  end

  def notice_for
    return [favorable.id] if favorable.is_a? User
    return [favorable.writer.id] if favorable.kind_of? Writing
    []
  end

  def notification_icon
    :kirari
  end

  def notification_translate
    return 'favorite_for.user' if favorable.is_a? User
    return 'favorite_for.' + favorable.class.to_s.downcase if favorable.kind_of? Writing
  end

  private

  def check_duplicate
    params = {
      user_id: self.user_id,
      favorable_type: self.favorable_type,
      favorable_id: self.favorable_id }

    raise ActiveRecord::RecordInvalid.new(self) if self.class.where(params).count > 0
  end

  def get_send_kirari_for_diary_stamp
    stamp = Stamp.find_by(slug: "send_kirari_for_#{favorable.class.to_s.downcase}")
    self.user.stamps << stamp if stamp.present? && ! self.user.stamps.include?(stamp)
  end
end
