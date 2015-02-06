namespace :valiation_image do
  task convert: :environment do
    ProductValiation.all.each do |v|
      tmp = v.images.build
      next unless v.image?
      tmp.src = v.image
      tmp.save
      v.remove_image!
      v.save
    end
  end
end
