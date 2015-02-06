class SearchQuery
  include ActiveModel::Model
  attr_reader :brand, :tag, :category
  attr_accessor :q, :page, :format

  def brand=(value)
    value = Brand.find value unless value.is_a? Brand
    @brand = value
  end

  def tag=(value)
    value = Tag.find value unless value.is_a? Tag
    @tag = value
  end

  def category=(value)
    value = Tag.find value unless value.is_a? Tag
    @category = value
  end

  def options
    _ = {}
    _[:brand] = brand.name if brand.present?
    _[:tag] = tag.name if tag.present?
    _[:tag] = category.name if category.present?
    _[:q] = q if q.present?
    _
  end

  def to_array
    _ = []
    _ << brand.name if brand.present?
    _ << tag.name if tag.present?
    _ << category.name if category.present?
    _ << q if q.present?
    _
  end
end
