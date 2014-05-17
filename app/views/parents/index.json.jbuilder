json.array!(@parents) do |parent|
  json.extract! parent, :id, :fatherName, :fatherDOB, :motherName, :motherDOB
  json.url parent_url(parent, format: :json)
end
