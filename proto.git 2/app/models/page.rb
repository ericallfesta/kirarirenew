class Page < ActiveRecord::Base
  validates_presence_of :title, :body, :slug
  validates_uniqueness_of :slug

  default_scope -> { order priority: :desc }

  def to_param
    slug.parameterize
  end

  def self.find slug
    find_by slug: slug
  end
end
