class AddTagsCountOnBodyParts < ActiveRecord::Migration
  def up
    transaction do
      add_column :body_parts, :tags_count, :integer, default: 0, after: :group_code

      BodyPart.reset_column_information
      BodyPart.all.each do |body_part|
        BodyPart.reset_counters(body_part, :body_part_tags)
      end
    end
  end

  def down
    remove_column :body_parts, :tags_count
  end
end
