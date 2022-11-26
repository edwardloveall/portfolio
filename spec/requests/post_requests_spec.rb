require "rails_helper"

RSpec.describe "Posts requests" do
  it "returns an rss response" do
    create(:post)

    get feed_url

    expect(response.media_type).to eq(Mime::Type.lookup_by_extension(:rss))
  end

  it "has channel and meta attributes" do
    travel_to Time.zone.local(2020, 1, 1, 0, 0, 0)
    create(:post)

    get feed_url

    rss = xml[:rss]
    channel = rss[:channel]
    expect(rss[:version]).to eq("2.0")
    expect(channel[:title]).to eq("Edward Loveall")
    expect(channel[:link]).to eq(feed_url)
    expect(channel[:lastBuildDate]).to eq("Wed, 01 Jan 2020 00:00:00 +0000")
    expect(channel[:language]).to eq("en-US")
    expect(channel[:description]).to eq("Edward Loveall's Blog")
  end

  context "for an internal post" do
    it "has entry attributes" do
      travel_to Time.zone.local(2020, 1, 1, 0, 0, 0)
      internal_post = create(
        :internal_post,
        title: "First post!",
        slug: "first-post",
        body: "Hello, world!"
      )
      create(:post, postable: internal_post)
      body_html = MarkdownRenderer.to_html("Hello, world!").html_safe

      get feed_url

      entry = xml[:rss][:channel][:item]
      expect(entry[:title]).to eq("First post!")
      expect(entry[:link]).to eq(internal_post_url("first-post", subdomain: "blog"))
      expect(entry[:description]).to eq(body_html)
      expect(entry[:pubDate]).to eq("Wed, 01 Jan 2020 00:00:00 +0000")
      expect(entry[:guid]).to eq(internal_post.guid)
    end
  end

  context "for an external post" do
    it "has entry attributes" do
      travel_to Time.zone.local(2020, 1, 1, 0, 0, 0)
      external_post = create(
        :external_post,
        title: "Post elsewhere",
        url: "https://other.com",
        teaser: "Read over there",
        posted_on: Date.new(2021, 1, 1)
      )
      create(:post, postable: external_post)

      get feed_url

      entry = xml[:rss][:channel][:item]
      expect(entry[:title]).to eq("Post elsewhere")
      expect(entry[:link]).to eq("https://other.com")
      expect(entry[:description]).to eq("Read over there")
      expect(entry[:pubDate]).to eq("Fri, 01 Jan 2021 00:00:00 +0000")
      expect(entry[:guid]).to eq(external_post.url)
    end
  end

  it "reports the guid as a non-permalink" do
    create(:post)

    get feed_url

    xml = Nokogiri::XML(response.body)
    guid = xml.at("guid")
    expect(guid.attribute("isPermaLink").value).to eq("false")
  end

  it "returns a 304 when there are no new posts" do
    create(:post)
    get feed_url
    headers = { "HTTP_IF_NONE_MATCH" => response.etag }

    get feed_url, headers: headers

    expect(response).to have_http_status(:not_modified)
  end

  it "returns a 200 when there are new posts" do
    Timecop.travel(Date.yesterday)
    create(:post)
    get feed_url
    headers = { "HTTP_IF_NONE_MATCH" => response.etag }
    Timecop.return
    create(:post)

    get feed_url, headers: headers

    expect(response).to have_http_status(:ok)
  end

  def xml
    Hash.from_xml(response.body).deep_symbolize_keys
  end

  def feed_url
    URI.join(root_url(subdomain: "blog"), "rss").to_s
  end
end
