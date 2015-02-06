class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :products, through: :taggings
  belongs_to :group, foreign_key: :group_id, class_name: :TagGroup
  has_many :body_part_tags
  has_many :body_parts, through: :body_part_tags
  has_many :rankings
  belongs_to :parent, class_name: Tag
  has_many :children, class_name: Tag, foreign_key: :parent_id
  has_many :evaluations, foreign_key: :category_id
  has_many :efficacies, foreign_key: :category_id

  accepts_nested_attributes_for :evaluations, reject_if: :all_blank

  validates :name, presence: true, length: { in: 1..32 }
  validates_inclusion_of :parent, in: lambda { |v| v.selectable_parent_tags }, allow_nil: true
  validate :parent_target

  scope :root, -> { where parent_id: nil }

  def build_evaluations
    (Report::EVALUATIONS_LIMIT - evaluations.length).times { self.evaluations.build }
  end

  # 子のタグ一覧を再帰的に取得する
  def recursive_children_tags
    self.children.map{ |c| [c] + c.recursive_children_tags }.flatten.uniq
  end

  def recursive_products
    taggings_table = Tagging.table_name.to_sym
    Product.joins(taggings_table).where("#{taggings_table}.tag_id IN (?)", recursive_children_tags.map { |v| v.id })
  end

  # 親カテゴリとして選択可能なタグの一覧を返す
  #
  #   親カテゴリとして指定できないもの
  #   - 選択するタグ自身
  #   - 選択するタグの子、及びその孫以下に属するタグ
  def selectable_parent_tags
    self.class.where.not( id: [self.id] + self.recursive_children_tags.map{ |v| v.id } )
  end

  def level
    return nil unless group == TagGroup.category
    parents.length + 1
  end

  def parents
    return [] if parent.blank?
    (parent.parents.present? ? parent.parents : []) << parent
  end

  def self.random_categories
    TagGroup.category.tags.order('RAND()')
  end

  def products_count
    self.class.products_count_cache[id].to_i
  end

  def self.products_count_cache
    @products_count_cache ||= Tagging.includes(:product).where('products.state' => 'published').group(:tag_id).count
  end

  private

  def parent_target
    errors.add :parent, :invalid if parent.present? && ! group.try(:is_category?)
  end
end
