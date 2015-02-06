class PopularKeyword < ActiveRecord::Base
  validates_presence_of :word, :priority
  validates_inclusion_of :deleted, in: [true, false]
  default_scope -> { where(deleted: false).order(priority: :desc) }
end
