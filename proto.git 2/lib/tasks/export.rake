namespace :export do
  task products: :environment do
    require 'csv'

    brand_id = ENV['brand_id']
    brand = Brand.find_by(id: brand_id)
    raise "Brand ID #{brand_id} is not exist" unless brand.present?

    data  = []
    brand.products.each do |product|
      tmp = []
      tmp[0] = product.name.to_s
      tmp[1] = product.description.to_s
      tmp[2] = product.valiations.map do |v|
        "#{v.name}: #{v.price}"
      end.join("\n").to_s
      tmp[3] = product.ingredient.to_s
      tmp[4] = product.source_url.to_s
      data << tmp
    end

    CSV.open Rails.root.join('tmp', "#{brand.name}.csv"), 'w' do |csv|
      data.each { |d| csv << d }
    end
  end

  task category: :environment do
    require 'csv'

    data = []

    TagGroup.category.tags.root.each do |c1|
      data << [c1.id, c1.name]

      c1.children.each do |c2|
        data << [c1.id, c1.name, c2.id, c2.name]

        c2.children.each do |c3|
          data << [c1.id, c1.name, c2.id, c2.name, c3.id, c3.name]

          c3.children.each do |c4|
            data << [c1.id, c1.name, c2.id, c2.name, c3.id, c3.name, c4.id, c4.name]
          end
        end
      end
    end

    CSV.open Rails.root.join('tmp', "categories.csv"), 'w' do |csv|
      data.each { |d| csv << d }
    end
  end
end
