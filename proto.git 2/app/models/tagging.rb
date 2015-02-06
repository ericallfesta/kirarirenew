class Tagging < ActiveRecord::Base
  belongs_to :product
  belongs_to :tag

  validates_uniqueness_of :product_id, scope: :tag_id
end
