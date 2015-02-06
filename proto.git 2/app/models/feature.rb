class Feature < ActiveRecord::Base
  validates_presence_of :title, :description, :url, :priority
  validates_length_of :title, in: 4..32
  validates_format_of :url, with: URI::regexp(%w(http https))
  validates_numericality_of :priority, greater_than: 0, only_integer: true

  default_scope -> { order active: :desc, priority: :asc, id: :asc }

  mount_uploader :hero_image, FeatureUploader
  mount_uploader :sidebar_image, FeatureUploader
end
