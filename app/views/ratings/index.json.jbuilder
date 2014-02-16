json.array!(@ratings) do |rating|
  json.extract! rating, :id, :score#, :beer_id, :user_id
end
