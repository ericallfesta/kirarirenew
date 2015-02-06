class Maker < ActiveRecord::Base

  has_many :products

  validates :name, presence: true, length: { in: 1..32 }
  validates_format_of :website, with: URI::regexp(%w(http https)), allow_blank: true

  default_scope { order created_at: :asc }

  mount_uploader :hero_image, FeatureUploader
end
