class Writing < ActiveRecord::Base
  include Noticeable
  include Favorable

  belongs_to :product
  belongs_to :writer, class_name: 'User'
  has_many :comments, after_add: :get_write_comment_for_stamp
  has_many :images, dependent: :destroy
  has_many :favorites, as: :favorable
  has_many :favorite_users, through: :favorites, source: :user

  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :all_blank

  validates_presence_of :writer, :body
  validate :validates_number_of_images

  after_validation :cleanup_images
  before_create :set_commented_at

  default_scope -> { order updated_at: :desc, commented_at: :desc }

  @@max_images_size = 3

  def build_images
    (@@max_images_size - self.images.size).times { self.images.build }
  end

  def label
    ''
  end

  def has_thumbnail?
    false
  end

  def thumbnail
    nil
  end

  def caption
    nil
  end

  TYPES = %w[diary report question]

  TYPES.each do |type|
    define_method "is_#{type}?" do
      type.to_s.downcase == __method__.to_s.gsub(/\Ais_([a-z]+)\?\z/, '\1')
    end
  end

  def notification_body_attributes
    { name: writer.display_name, title: title }
  end

  def notification_link
    "/#{type.pluralize.downcase}/#{id}"
  end

  def notification_icon
    self.class.to_s.underscore
  end

  def get_write_comment_for_stamp comment
  end

  def notice_for
    self.writer.followers.inject([]) { |users, follower| users << follower.id }
  end

  def self.search options = {}
    p = self

    p = p.where(["`title` LIKE ? OR `body` LIKE ?", "%#{options[:q].to_s}%", "%#{options[:q].to_s}%"]) if options[:q].present?

    p
  end

  private
    def cleanup_images
      return unless self.errors.blank?
      self.images.each do |image|
        image.destroy if image.remove_src?
      end
    end

    def validates_number_of_images
      return unless self.images.size > @@max_images_size
      self.errors.add :images, "は#{@@max_images_size}枚まで添付できます"
    end

    def set_commented_at
      self.commented_at = Time.now
    end
end
