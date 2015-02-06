class Brand < ActiveRecord::Base
  include Search
  include Favorable

  has_many :users
  has_many :favorites, as: :favorable
  has_many :favorite_users, through: :favorites, source: :user
  has_many :products

  validates :name, presence: true, length: { in: 1..32 }
  validates_format_of :website, with: URI::regexp(%w(http https)), allow_blank: true

  default_scope { order created_at: :asc }

  mount_uploader :hero_image, FeatureUploader
  mount_uploader :image, DefaultUploader

  def categories
    products.map(&:category).uniq
  end

  def populars(limit)
    products.order( star: :desc ).limit(limit)
  end

  def excerpt
    description.to_s
  end

  def name_with_kana
    display_kana && kana.present? ? "#{name} (#{kana})" : name
  end
end
