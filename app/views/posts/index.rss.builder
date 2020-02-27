xml.instruct! :xml, version: "1.0"

xml.rss version: "2.0" do
  xml.channel do
    xml.title title
    xml.link root_url(subdomain: "blog") + "rss"
    xml.lastBuildDate @posts.first.created_at.rfc822
    xml.language "en-US"
    xml.description "Edward Loveall's Blog"

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.link post_url(post.slug, subdomain: "blog")
        xml.description convert_markdown(post.body)
        xml.pubDate post.created_at.rfc822
        xml.guid post.guid, isPermaLink: false
      end
    end
  end
end
