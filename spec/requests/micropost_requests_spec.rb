require 'rails_helper'

RSpec.describe 'Snippet requests' do
  describe 'get #feed' do
    it 'returns an rss response' do
      create(:micropost)

      get microblog_feed_url

      expect(response.content_type).to eq(Mime::Type.lookup_by_extension(:rss))
    end

    it 'has a channel and meta attributes' do
      micropost = create(:micropost)

      get microblog_feed_url

      rss = xml[:rss]
      channel = rss[:channel]

      expect(rss[:version]).to eq('2.0')
      expect(channel[:link]).to eq(microblog_feed_url)
      expect(channel[:lastBuildDate]).to eq(micropost.created_at.to_s)
      expect(channel[:language]).to eq('en-US')
    end

    it 'has entry attributes' do
      micropost = create(:micropost)

      get microblog_feed_url
      entry = xml[:rss][:channel][:item]

      expect(entry[:link]).to eq(microblog_url(micropost.timestamp))
      expect(entry[:description]).to eq(micropost.body)
      expect(entry[:pubDate]).to eq(micropost.created_at.to_s)
      expect(entry[:guid]).to eq(micropost.guid)
    end

    it 'reports the guid as a non-permalink' do
      create(:micropost)

      get microblog_feed_url

      xml = Nokogiri::XML(response.body)
      guid = xml.at('guid')

      expect(guid.attribute('isPermalink').value).to eq('false')
    end

    it 'returns a 304 when there are no new posts' do
      create(:micropost)
      get microblog_feed_url
      headers = { 'HTTP_IF_NONE_MATCH' => response.etag }

      get microblog_feed_url, headers: headers

      expect(response).to have_http_status(:not_modified)
    end

    it 'returns a 200 when there are new posts' do
      Timecop.travel(Date.yesterday)
      create(:micropost)
      get microblog_feed_url
      headers = { 'HTTP_IF_NONE_MATCH' => response.etag }
      Timecop.return
      create(:micropost)

      get microblog_feed_url, headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  def xml
    Hash.from_xml(response.body).deep_symbolize_keys
  end
end
