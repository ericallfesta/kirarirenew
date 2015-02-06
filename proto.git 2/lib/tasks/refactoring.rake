namespace :refactoring do
  task r20141003: :environment do
    recreate_images!
  end

  def recreate_images!
    Product.where.not(image: nil).each do |product|
      product.images.create(primary: true, src: product.image)
    end

    VariationImage.all.each do |image|
      image.variation.images.create(src: image.src)
    end
  end
end
