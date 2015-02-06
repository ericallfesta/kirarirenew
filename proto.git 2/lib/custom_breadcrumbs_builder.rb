class CustomBreadcrumbsBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
  def render
    @context.render "/shared/breadlist", elements: @elements
  end
end
