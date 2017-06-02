json.version 'https://jsonfeed.org/version/1'
json.title title
json.home_page_url microposts_url
json.feed_url microposts_feed_url(format: :json)
json.author do
  json.name t('titles.microposts.author')
end

json.items @microposts.each do |micropost|
  json.url micropost_ms_epoch_url(micropost.ms_epoch)
  json.content_html convert_markdown(micropost.body)
  json.id micropost.guid
  json.date_published micropost.created_at.to_datetime.rfc3339
  json.author do
    json.name t('titles.microposts.author')
    json.url root_url
  end
end
