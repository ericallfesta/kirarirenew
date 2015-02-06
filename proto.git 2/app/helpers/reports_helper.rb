module ReportsHelper
  def new_report_path(resource = nil, parameters = {})
    resource = Product.published.find(resource) if resource.is_a?(Integer)

    if resource.is_a?(Product)
      parameters[:product_id] = resource.id
      resource = nil
    end

    super(resource, parameters)
  end

  def star_list
    (0..5).to_a.inject([]) do |list, number|
      list << "<span class=\"star star#{number} icon icon-star-empty\" data-value=\"#{number}\" title=" + t("views.label.star_list.item#{number}") + "></span>"
    end
  end
end
