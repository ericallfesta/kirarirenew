class ConvertBetweenBodyPartsAndTags < ActiveRecord::Migration
  def up
    transaction do
      execute "INSERT INTO body_part_tags (`body_part_id`, `tag_id`) SELECT `body_part_id`, `id` AS `tag_id` FROM `tags`"
    end
  end

  def down
  end
end
