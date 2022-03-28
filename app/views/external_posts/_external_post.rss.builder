xml.item do
  xml.title external_post.title
  xml.link external_post.url
  xml.description external_post.teaser
  xml.pubDate l(external_post.posted_on, format: :rfc822_with_leading_zero_date)
  xml.guid external_post.guid, isPermaLink: false
end
