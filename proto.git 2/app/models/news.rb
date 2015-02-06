class News < ActiveRecord::Base
  STATUSES = %w(draft publish)

  belongs_to :writer, class_name: 'User'

  validates_presence_of :title, :body, :writer, :status, :published_at

  default_scope -> { order published_at: :desc, updated_at: :desc }

  scope :published, -> { where{ status.eq('publish') & (published_at.eq(nil) | published_at.lt(Time.now)) } }

  mount_uploader :image, NewsUploader
end
