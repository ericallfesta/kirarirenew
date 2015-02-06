class BodyPartTag < ActiveRecord::Base
  belongs_to :tag
  belongs_to :body_part, counter_cache: :tags_count
end
