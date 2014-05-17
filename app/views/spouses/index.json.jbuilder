json.array!(@spouses) do |spouse|
  json.extract! spouse, :id, :fullname, :dob, :gender, :child_id
  json.url spouse_url(spouse, format: :json)
end
