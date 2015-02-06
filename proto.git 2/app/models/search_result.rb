class SearchResult
  include ActiveModel::Model

  def initialize(options={})
    options[:per] ||= 3
    options[:page] ||= 1
    options[:has_list] = true if options[:has_list].nil?
    options[:heading] ||= "search_#{options[:as].to_s.downcase}"
    options[:action] ||= options[:as] if options.has_key? :as

    super(options)
  end

  attr_accessor :as, :proxy, :per, :page, :has_list, :heading, :action

  def each(&block)
    list.each(&block) if block_given?
  end

  def list
    proxy.page(page).per(per)
  end

  def length
    list.length
  end

  def singularize
    as.to_s.singularize
  end

  def allow_list?
    has_list
  end
end
