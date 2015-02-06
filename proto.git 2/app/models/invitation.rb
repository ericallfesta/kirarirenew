class Invitation < ActiveRecord::Base
  belongs_to :user, autosave: false

  validates_presence_of :name, :email
  validates_uniqueness_of :key, :email
  validates :email, email: true

  before_save :set_key

  class << self
    def by_email email
      find_by email: email
    end
  end

  def deliver
    InvitationMailer.invitation(self).deliver
  end

  protected
    def set_key
      self.key = SecureRandom.uuid if self.key.nil?
    end
end
