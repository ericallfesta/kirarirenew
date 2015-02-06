class UserStamp < ActiveRecord::Base
  include Noticeable

  belongs_to :user
  belongs_to :stamp

  validates_presence_of :user, :stamp

  after_create :add_point

  def notification_body_attributes
    { name: user.display_name, label: stamp.label }
  end

  def notification_link
    "/users/#{user.id}/stamps"
  end

  def notice_for
    [user.id]
  end

  private

  def add_point
    self.user.add_point(self.stamp)
  end
end
