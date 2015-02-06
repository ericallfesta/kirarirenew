class RequestProduct < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_presence_of :name, :user
  validates_length_of :name, maximum: 50
  validates_length_of :brand, maximum: 50, allow_blank: true
  validates_format_of :product_url, with:URI::regexp(%w(http https)), allow_blank: true
  validates_format_of :brand_url, with: URI::regexp(%w(http https)), allow_blank: true
  validates_inclusion_of :status, in: %w(waiting registered refused)

  after_create :send_mail_to_admin_users

  def send_mail_to_admin_users
    RequestProductMailer.notify_created
  end

  def send_mail_to_created_user
    RequestProductMailer.notify_product_info self
  end
end
