json.result do
  json.array! @products do |product|
    json.extract! product, :display_price, :description, :name, :id
    json.url url_for product
    json.main_image do
      json.src do
        json.square do
          json.alt ''
          json.src product.main_image.src.square.url
        end
      end
    end
    json.star do
      json.face star(product.star)
      json.round product.star.round(1).to_s unless product.star.nil?
    end
    json.brand do
      json.extract! product.brand, :name
    end
  end
end
json.queries @queries.to_array
json.total @products.total_count
json.pages @products.total_pages
