json.array!(@documents) do |document|
  json.(document, :id, :title, :body, :user_id, :annotatings, :references)
end