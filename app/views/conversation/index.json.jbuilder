json.array! @conversations do |conversation|
  json.id conversation[:id]
  json.participants conversation[:participants]
end