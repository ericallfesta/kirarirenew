module SearchHelper
  def search_tag_path tag
    params = { tag: tag.id }
    url_for( controller: 'search/basic', action: :result ) + "?#{params.to_query}"
  end

  def body_groups
    [:head, :upper, :arms, :lower, :etc]
  end

  def tag_groups
    [:symptom, :purpose, :target, :nature]
  end

  def bodymap_tag_groups
    tag_groups
  end
end
