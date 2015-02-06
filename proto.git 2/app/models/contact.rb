class Contact
  include ActiveModel::Model

  attr_accessor :address, :subject, :body, :to_all, :to_admin

  validates_presence_of :subject, :body
  validates_length_of :subject, in: 2..100
  validates_length_of :body, in: 2..1024
  validates_inclusion_of :to_all, in: ['0', '1', 0, 1], allow_blank: true
  validates_inclusion_of :to_admin, in: ['0', '1', 0, 1], allow_blank: true
  validates :address, email: true, allow_blank: true
  validate :exist_any_target

  def deliver
    ContactMailer.contact(self).deliver if self.address.present?
    build_user_mails.each {|mail| ContactMailer.contact(mail).deliver }
  end

  def build_user_mails
    klass = User.all if to_all.to_i == 1
    klass = User.where(role: 'admin') if to_admin.to_i == 1
    return [] unless klass.present?

    klass.inject([]) do |r, u|
      r += [self.class.new(address: u.email, subject: self.subject, body: self.body)]
    end
  end

  private

  def exist_any_target
    return if self.address.present? || self.to_all.to_i == 1 || self.to_admin.to_i == 1
    self.errors.add :address, "が設定されていません。"
  end
end
