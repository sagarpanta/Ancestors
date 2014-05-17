json.array!(@children) do |child|
  json.extract! child, :id, :fullname, :dob, :gender, :parent_id
  json.url child_url(child, format: :json)
end
