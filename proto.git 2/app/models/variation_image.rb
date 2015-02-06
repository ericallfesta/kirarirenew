class VariationImage < ActiveRecord::Base
  belongs_to :variation, class_name: ProductVariation, foreign_key: :product_variation_id

  validates_presence_of :src

  mount_uploader :src, ProductUploader
end
