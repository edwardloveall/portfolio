require 'rails_helper'

RSpec.describe 'Posts requests' do
  it 'returns an rss response' do
    create(:post)

    get feed_url

    expect(response.media_type).to eq(Mime::Type.lookup_by_extension(:rss))
  end

  it 'has channel and meta attributes' do
    post = create(:post)

    get feed_url

    rss = xml[:rss]
    channel = rss[:channel]

    expect(rss[:version]).to eq('2.0')
    expect(channel[:title]).to eq('Edward Loveall')
    expect(channel[:link]).to eq(feed_url)
    expect(channel[:lastBuildDate]).to eq(post.created_at.to_s)
    expect(channel[:language]).to eq('en-US')
  end

  it 'has entry attributes' do
    create(:post)
    post = create(:post)
    post_body = MarkdownRenderer.to_html(post.body).html_safe

    get feed_url

    entry = xml[:rss][:channel][:item].first

    expect(entry[:title]).to eq(post.title)
    expect(entry[:link]).to eq(post_url(post.slug, subdomain: 'blog'))
    expect(entry[:description]).to eq(post_body)
    expect(entry[:pubDate]).to eq(post.created_at.to_s)
    expect(entry[:guid]).to eq(post.guid)
  end

  it 'reports the guid as a non-permalink' do
    create(:post)

    get feed_url

    xml = Nokogiri::XML(response.body)
    guid = xml.at('guid')

    expect(guid.attribute('isPermalink').value).to eq('false')
  end

  it 'returns a 304 when there are no new posts' do
    create(:post)
    get feed_url
    headers = { 'HTTP_IF_NONE_MATCH' => response.etag }

    get feed_url, headers: headers

    expect(response).to have_http_status(:not_modified)
  end

  it 'returns a 200 when there are new posts' do
    Timecop.travel(Date.yesterday)
    create(:post)
    get feed_url
    headers = { 'HTTP_IF_NONE_MATCH' => response.etag }
    Timecop.return
    create(:post)

    get feed_url, headers: headers

    expect(response).to have_http_status(:ok)
  end

  def xml
    Hash.from_xml(response.body).deep_symbolize_keys
  end

  def feed_url
    "#{root_url(subdomain: 'blog')}rss"
  end
end
