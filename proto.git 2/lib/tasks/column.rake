namespace :column do
  desc "Recreate image versions"
  task recreate_images: :environment do
    Column.where.not(image: nil).each do |column|
      column.image.recreate_versions! if column.image?
    end
  end
end
