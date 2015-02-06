class IngredientsList
  include Mongoid::Document

  field :product_id, type: Integer
  field :ingredients, type: Array, default: []
  field :checked, type: Boolean, default: false
  field :active, type: Boolean, default: false

  validates_presence_of :product

  index({ product_id: 1 }, { name: "product_id_index" })
  index({ ingredients: 1 }, { name: "ingredients_index" })

  def to_array
    self.ingredients ||= []
  end

  def refresh text
    self.ingredients = text.tokenize
    self.checked = false
    self.active = false
    save
  end

  def length
    self.ingredients.length
  end

  def self.find_by_product product
    product = Product.published.find product if product.is_a? Integer
    raise "Invalid Argument #1" unless product.is_a? Product
    where(product_id: product.id).first_or_create
  end
end
