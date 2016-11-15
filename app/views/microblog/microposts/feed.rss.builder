xml.instruct! :xml, version: '1.0'

xml.rss version: '2.0' do
  xml.channel do
    xml.title title
    xml.link microblog_feed_url
    xml.lastBuildDate @microposts.first.created_at
    xml.language 'en-US'

    @microposts.each do |micropost|
      xml.item do
        xml.description micropost.body
        xml.link microblog_url(micropost.timestamp)
        xml.pubDate micropost.created_at
        xml.guid micropost.guid, isPermalink: false
      end
    end
  end
end
