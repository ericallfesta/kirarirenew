namespace :product do
  desc "TODO"
  task update_star: :environment do
    Product.all.each { |product| product.update_star! force: true }
  end

  desc "Recreate image versions"
  task recreate_images: :environment do
    Product.where.not(image: nil).each do |product|
      product.image.recreate_versions! if product.image?
    end
    ProductValiation.where.not(image: nil).each do |valiation|
      valiation.image.recreate_versions! if valiation.image?
    end
  end

  desc "Kana convert"
  task convert_kana: :environment do
    routes = Rails.application.routes.url_helpers

    t = translator("ァ-ン", "ぁ-ん")
    Product.unscoped.all.each do |product|
      next if product.kana.present?
      product.kana = t.call(product.name)
      product.save
      puts "##{product.id}"
      puts " #{product.name}"
      puts " ↓"
      puts " #{product.kana}"
      puts " #{routes.url_for(host: "kirari.it", controller: 'admin/products', action: "show", id: product.id)}"
      puts
    end
  end

  desc "Remove some prefix from product name"
  task remove_name_prefix: :environment do
    prefixes = %w(DHC えがおの)

    Brand.where(name: ['DHC', 'えがお']).each do |brand|
      brand.products.order(:name).each do |product|
        before = product.name

        if product.name =~ /\A(#{prefixes.join("|")})/
          product.name = product.name.gsub(/\A(#{prefixes.join("|")})/, '').gsub('　', ' ').gsub(/\A\ {1,}/, '')
          product.save
          puts "##{product.id}"
          puts " #{before}"
          puts " ↓"
          puts " #{product.name}"
          puts
        end
      end
    end
  end

  def translator(from, to)
    lambda {|str| str.tr(from, to) }
  end
end
