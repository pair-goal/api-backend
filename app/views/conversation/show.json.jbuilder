json.array! @messages do |message|
  json.extract! message, :conversation_id, :sender, :content, :created_at
end