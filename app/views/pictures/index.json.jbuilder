json.array!(@pictures) do |picture|
  json.extract! picture, :id, :user_id, :description, :num_of_images
  json.url picture_url(picture, format: :json)
end
