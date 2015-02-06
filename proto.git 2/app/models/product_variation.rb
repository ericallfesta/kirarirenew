class ProductVariation < ActiveRecord::Base
  belongs_to :product
  has_many :images, class_name: ProductImage, foreign_key: :variation_id

  validates_presence_of :name, :product
  validates_length_of :name, in: 1..50
  validates_format_of :website, with: URI::regexp(%w(http https)), allow_blank: true

  mount_uploader :image, ProductUploader

  def display_price
    if price.present?
      price.to_currency() + I18n.t('views.price_unit')
    else
      price_note
    end
  end
end
