module QuestionsHelper
  def new_question_path(resource = nil, parameters = {})
    resource = Product.published.find(resource) if resource.is_a?(Integer)

    if resource.is_a?(Product)
      parameters[:product_id] = resource.id
      resource = nil
    end

    super(resource, parameters)
  end
end
