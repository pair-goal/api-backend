json.array!  @goals do |goal|
  json.extract! goal, :id, :title, :category_num, :start_date, :end_date, :is_doing, :image_path, :partner_id
end