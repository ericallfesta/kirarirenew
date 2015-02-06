class MetaControl
  include ActiveModel::Model

  class << self

    def create(model, options={})
      meta = self.new
      meta.description = model.description if model.respond_to? :description
      meta.canonical_url = model.canonical_url if model.respond_to? :canonical_url
      meta.merge(options)

      meta
    end

  end

  def initialize(options={})
    options[:index] = true unless options.has_key? :index
    options[:follow] = true unless options.has_key? :follow
    super(options)
  end

  attr_accessor :title, :description, :keywords, :image, :canonical_url, :index, :follow, :parent

  def merge(params)
    case params
    when Hash
      merge_hash params
    when MetaControl
      merge_meta_control params
    else
      raise "invalid params"
    end
  end

  def params
    _ = {}
    _[:description] = description if description
    _[:keywords] = keywords_str if keywords
    _[:title] = title if title
    _[:robots] = "#{index_str}, #{follow_str}"
    _[:canonical] = canonical_url if canonical_url
    _
  end

  def index_str
    self.index ? 'index' : 'noindex'
  end

  def follow_str
    self.follow ? 'follow' : 'nofollow'
  end

  def keywords_str
    keywords.is_a? Array ? keywords.join(' ') : keywords.to_s
  end

  def image_url
    self.image || ActionController::Base.helpers.asset_path("ogp.png")
  end

  protected

  MERGEABLE_PARAMS = %i[title description keywords image canonical_url index follow]

  def merge_hash(hash)
    MERGEABLE_PARAMS.each do |key|
      self.send(:"#{key}=", hash[key]) if hash.has_key? key
    end
  end

  def merge_meta_control(meta_control)
    new_meta_control = self.class.new parent: self
    MERGEABLE_PARAMS.each do |key|
      new_meta_control.send(:"#{key}=", meta_control.send(key))
    end
    new_meta_control
  end
end
