json.array! @conversations do |conversation|
  json.array! conversation do |c|
    json.extract! c, :_id, :nickname, :title
  end
end