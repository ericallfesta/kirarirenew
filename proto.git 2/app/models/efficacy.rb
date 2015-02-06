class Efficacy < ActiveRecord::Base
  belongs_to :category, class_name: Tag
  validates_presence_of :category, :name
end
