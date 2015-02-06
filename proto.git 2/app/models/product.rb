class Product < ActiveRecord::Base
  include Star
  include Favorable

  belongs_to :brand
  belongs_to :maker
  has_many :writings
  has_many :reports
  has_many :questions
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :favorites, as: :favorable
  has_many :favorite_users, through: :favorites, source: :user
  has_many :images, class_name: ProductImage
  has_many :variations, class_name: ProductVariation
  has_many :variation_images, through: :variations, class_name: ProductImage, source: :images

  accepts_nested_attributes_for :variations, reject_if: :all_blank

  validates_presence_of  :name, :description, :brand
  validates_length_of :name, in: 2..50
  validates_format_of :source_url, with: URI::regexp(%w(http https)), allow_blank: true
  validates_inclusion_of :state, in: %w(published draft)
  validates_numericality_of :star, greater_than_or_equal_to: 0, less_than: 6, allow_blank: true
  validate :present_category

  before_save :update_star

  default_scope { order star: :desc, kana: :asc, name: :asc, created_at: :asc }
  scope :published, -> { where state: 'published' }
  scope :scored, -> { where(state: 'published').where('reports_count > 0') }
  scope :draft, -> { where state: 'draft' }

  mount_uploader :image, ProductUploader

  ranking_with :access, scope: :published
  ranking_with :score, scope: :scored, attribute_name: :star

  def evaluations
    category.try(:evaluations) || []
  end

  def calculate_evaluation evaluation
    ReportEvaluation.where(evaluation: evaluation, report: reports).where.not(star: nil).average :star
  end

  def update_star(options={})
    self.reports_count = self.reports.count
    rated_reports = reports.where.not(star: nil)

    if rated_reports.count == 0
      self.star = nil
    else
      self.star = ( 2.5 + rated_reports.inject(0) { |sum, r| sum += r.star.presence || 0 }.to_f ) / ( 1 + rated_reports.count )
    end
  end

  def update_star!(options={})
    update_star(options)
    save
  end

  def access!
    self.access_number += 1
    self.save
  end

  def score
    rated_reports = reports.where.not(star: nil)
    return 2.5 if rated_reports.count == 0
    total = 2.5 + rated_reports.inject(0) { |sum, r| sum += r.star.presence || 0 }.to_f
    return total / ( 1 + rated_reports.count )
  end

  def self.top(tag = nil, length=3)
    ranking = self.score_ranking.ranged(:yesterday)
    ranking = ranking.in(tag) unless tag.nil?
    ranking.per_page = 3
    ranking.page 1
  end

  def has_variations?
    self.variations.length > 0
  end

  def ingredients_list
    IngredientsList.find_by_product(self)
  end

  def display_price
    if price.present?
      price.to_s + I18n.t('views.price_unit')
    elsif price_note.present?
      price_note
    elsif has_variations?
      variations.first.try :display_price
    end
  end

  def main_image
    images.reorder(primary: :desc, created_at: :asc).first_or_initialize
  end

  def main_price
    if price.present?
      price
    elsif has_variations? && variations.first.price.present?
      variations.first.price
    end
  end

  def main_ingredient
    if ingredient.present?
      ingredient
    elsif has_variations?
      variations.where.not('ingredient', nil).first.try :ingredient
    end
  end

  def self_images
    images.where variation: nil
  end

  def category
    tags.select{|tag| tag.group.try(:slug) == 'category' }.first
  end

  def to_meta
    MetaControl.create self, image: self.image.thumbnail.url
  end

  def self.search options = {}
    p = self.published
    p = p.joins(:taggings).where(["`taggings`.`tag_id` = ?", options[:tag]]) if options[:tag].present?
    p = p.joins(:brand).where(["`products`.`name` LIKE ?  OR `products`.`description` LIKE ? OR `brands`.`name` LIKE ?", "%#{options[:q]}%", "%#{options[:q]}%", "%#{options[:q]}%"]) unless options[:q].nil?
    p = p.where(["`products`.`kana` LIKE ?", "#{options[:kana]}%"]) unless options[:kana].nil?
    p = p.joins(:taggings).where(["`taggings`.`tag_id` IN (?) ", [ options[:category] ] + options[:category].recursive_children_tags]) if options[:category].present? && options[:category].try(:group) == TagGroup.category
    p = p.where(brand_id: options[:brand]) if options[:brand].present?
    p = p.joins(:taggings).where(["`taggings`.`tag_id` IN (?) ", options[:tags]]) if options[:tags].present?

    p
  end

  private

  def present_category
    errors.add :category, :blank if category.blank?
  end
end
