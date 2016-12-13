json.microposts do
  json.array! @microposts do |micropost|
    json.partial! micropost
  end
end
