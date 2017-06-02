require 'rails_helper'

RSpec.describe 'Micropost requests' do
  describe 'get #feed' do
    it 'returns an rss response' do
      create(:micropost)

      get microposts_feed_url

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:rss))
    end

    it 'has a channel and meta attributes' do
      micropost = create(:micropost)

      get microposts_feed_url

      rss = xml[:rss]
      channel = rss[:channel]

      expect(rss[:version]).to eq('2.0')
      expect(channel[:title]).to eq("Edward Loveall's Microblog")
      expect(channel[:link]).to eq(microposts_feed_url)
      expect(channel[:lastBuildDate]).to eq(micropost.created_at.to_s)
      expect(channel[:language]).to eq('en-US')
    end

    it 'has entry attributes' do
      micropost = create(:micropost)
      body = MarkdownRenderer.to_html(micropost.body)

      get microposts_feed_url
      entry = xml[:rss][:channel][:item]

      expect(entry[:link]).to eq(micropost_ms_epoch_url(micropost.ms_epoch))
      expect(entry[:description]).to eq(body)
      expect(entry[:pubDate]).to eq(micropost.created_at.to_s)
      expect(entry[:guid]).to eq(micropost.guid)
    end

    it 'renders the body as html' do
      body = '[link](https://edwardloveall.com)'
      html = "<p><a href=\"https://edwardloveall.com\">link</a></p>\n"
      create(:micropost, body: body)

      get microposts_feed_url
      entry = xml[:rss][:channel][:item]

      expect(entry[:description]).to eq(html)
    end

    it 'reports the guid as a non-permalink' do
      create(:micropost)

      get microposts_feed_url

      xml = Nokogiri::XML(response.body)
      guid = xml.at('guid')

      expect(guid.attribute('isPermalink').value).to eq('false')
    end

    it 'returns a 304 when there are no new posts' do
      create(:micropost)
      get microposts_feed_url
      headers = { 'HTTP_IF_NONE_MATCH' => response.etag }

      get microposts_feed_url, headers: headers

      expect(response).to have_http_status(:not_modified)
    end

    it 'returns a 200 when there are new posts' do
      Timecop.travel(Date.yesterday)
      create(:micropost)
      get microposts_feed_url
      headers = { 'HTTP_IF_NONE_MATCH' => response.etag }
      Timecop.return
      create(:micropost)

      get microposts_feed_url, headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  def xml
    Hash.from_xml(response.body).deep_symbolize_keys
  end
end
