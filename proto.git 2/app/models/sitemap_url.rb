class SitemapUrl
  include ActiveModel::Model
  include ActionDispatch::Routing::PolymorphicRoutes

  attr_accessor :loc, :lastmod, :changefreq, :priority

  CHANGEFREQ = %w[always hourly daily weekly monthly yearly never]

  validates_presence_of :loc
  validates_format_of :lastmod, with: /\A[0-9]{4}-[0-9]{2}-[0-9][2]\z/, allow_nil: true
  validates_inclusion_of :changefreq, in: CHANGEFREQ, allow_nil: true

  def initialize(options={})
    options.symbolize_keys!

    options[:loc] = polymorphic_url(options[:model]) if options.has_key? :model
    options[:lastmod] = options[:model].updated_at.strftime('%Y-%m-%d') if options.has_key? :model
    options.delete :model

    super(options)
  end

  def to_hash
    _ = { loc: "http://kirari.it/#{loc.gsub(/\A\//, '')}" }
    _[:lastmod] = lastmod unless lastmod.nil? || lastmod.empty?
    _[:changefreq] = changefreq unless changefreq.nil? || changefreq.empty?
    _[:priority] = priority unless priority.nil? || priority.empty?
    _
  end

  def to_xml
    "<url>#{to_hash.map{|k,v|"<#{k}>#{v}</#{k}>"}.join}</url>"
  end

  protected

  def product_url(product)
    "/products/#{product.id}"
  end

  def brand_url(brand)
    "/brands/#{brand.id}"
  end

  def report_url(report)
    "/users/#{report.writer_id}/reports/#{report.id}"
  end

  def question_url(question)
    "/users/#{question.writer_id}/questions/#{question.id}"
  end
end
