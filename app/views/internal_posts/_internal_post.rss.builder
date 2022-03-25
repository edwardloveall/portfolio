xml.item do
  xml.title internal_post.title
  xml.link internal_post_url(internal_post.slug, subdomain: "blog")
  xml.description convert_markdown(internal_post.body)
  xml.pubDate internal_post.created_at.rfc822
  xml.guid internal_post.guid, isPermaLink: false
end
