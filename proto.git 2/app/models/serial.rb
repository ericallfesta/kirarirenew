class Serial < ActiveRecord::Base
  belongs_to :writer, class_name: 'User'
  has_many :columns

  STATUSES = %i(open close)

  validates_presence_of :description, :published_at, :title, :status
  validates_length_of :title, in: 4..32
  validates_inclusion_of :status, in: STATUSES.map(&:to_s)

  scope :recents, -> { where id: Column.order(created_at: :desc).pluck(:serial_id).uniq.select(&:present?).try(:[], (0..2)) }
  scope :opened, -> {  where{ status.eq('open') & (published_at.eq(nil) | published_at.lt(Time.now)) }.order(published_at: :desc) }

  mount_uploader :image, DefaultUploader
  paginates_per 5
end
