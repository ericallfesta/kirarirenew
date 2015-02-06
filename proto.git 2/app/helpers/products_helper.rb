module ProductsHelper
  def product_reports_path(resource)
    "/products/#{resource.id}/reports"
  end
end
