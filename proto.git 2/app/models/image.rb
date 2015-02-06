class Image < ActiveRecord::Base
  belongs_to :writing
  validates_presence_of :src
  mount_uploader :src, DefaultUploader
end
