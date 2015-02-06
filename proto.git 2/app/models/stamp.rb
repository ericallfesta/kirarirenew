class Stamp < ActiveRecord::Base
  has_many :user_stamps
  has_many :users, through: :user_stamps

  validates_presence_of :point, :label, :slug

  def image
    "stamps/#{slug}.png"
  end

  def unacquired_image
    "stamps/unacquired.png"
  end

  def tutorial_image
    "tutorials/#{slug}.gif"
  end
end
