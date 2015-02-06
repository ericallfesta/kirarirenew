json.array!(@comments) do |comment|
  json.extract! comment, :id
  json.body h(comment.body)
  json.created_at l(comment.created_at)
  json.user do
    json.display_name h(comment.user.display_name)
    json.image do
      json.thumbnail do
        json.src comment.user.image.thumbnail.url
      end
    end
    json.url user_path(comment.user)
  end
end
