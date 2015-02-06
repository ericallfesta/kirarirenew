class Follow < ActiveRecord::Base
  include Noticeable

  belongs_to :user
  belongs_to :followable, polymorphic: true
  belongs_to :followed_user, class_name: 'User', foreign_key: 'followable_id'
  belongs_to :followed_brand, class_name: 'Brand', foreign_key: 'followable_id'

  validates_presence_of :user, :followable
  validates_inclusion_of :followable_type, in: %w(User Brand)

  after_create :get_stamp_followed_3_users
  after_create :get_stamp_followed_1_brand

  def name
    case followable_type
    when 'User'
      followable.display_name
    when 'Brand'
      followable.name
    else
      ''
    end
  end

  def notification_body_attributes
    { from: user.display_name, to: followable.name }
  end

  def notification_link
    "/users/#{user.id}"
  end

  def notification_icon
    :follower
  end

  def notice_for
    return [followable.id] if followable_type == 'User'
    []
  end

  private

  def get_stamp_followed_3_users
    stamp = Stamp.find_by slug: 'followed_3_users'
    self.user.stamps << stamp if user.followed_users.length >= 3 && stamp.present? && ! user.stamps.include?(stamp)
  end

  def get_stamp_followed_1_brand
    stamp = Stamp.find_by slug: 'followed_1_brand'
    self.user.stamps << stamp if user.followed_brands.length >= 1 && stamp.present? && ! user.stamps.include?(stamp)
  end
end
