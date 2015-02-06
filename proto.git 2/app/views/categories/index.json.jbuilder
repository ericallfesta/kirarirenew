json.array!(@categories) do |category|
  json.extract! category, :name, :id
  json.children do
    json.array!(category.children) do |category|
      json.extract! category, :name, :id
    end
  end
end
