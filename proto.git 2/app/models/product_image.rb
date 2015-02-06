class ProductImage < ActiveRecord::Base
  belongs_to :product
  belongs_to :variation, class_name: ProductVariation, foreign_key: :variation_id

  validates_presence_of :src, :product
  validates_inclusion_of :primary, in: [true, false]

  before_validation :set_product
  before_save :reset_primary, if: :primary

  default_scope -> { order primary: :desc, created_at: :asc }

  default_value_for :primary, false
  mount_uploader :src, ProductUploader

  def set_product
    self.product = self.variation.product if variation.present?
  end

  def reset_primary
    product.images.where(primary: true).each { |i| i.update primary: false }
  end
end
