namespace :news do
  desc "Recreate image versions"
  task recreate_images: :environment do
    News.where.not(image: nil).each do |news|
      news.image.recreate_versions! if news.image?
    end
  end
end
