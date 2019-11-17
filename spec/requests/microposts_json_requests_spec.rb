require 'rails_helper'

RSpec.describe 'Micropost json requests' do
  describe 'get #feed' do
    it 'returns a json response' do
      create(:micropost)

      get microposts_feed_url(format: :json)

      expect(response.media_type).to eq(Mime::Type.lookup_by_extension(:json))
    end

    it 'has meta attributes' do
      get microposts_feed_url(format: :json)

      expect(json[:version]).to eq('https://jsonfeed.org/version/1')
      expect(json[:title]).to eq("Edward Loveall's Microblog")
      expect(json[:home_page_url]).to eq(microposts_url)
      expect(json[:feed_url]).to eq(microposts_feed_url(format: :json))
    end

    it 'has an author element' do
      get microposts_feed_url(format: :json)

      expect(json[:author][:name]).to eq('Edward Loveall')
    end

    it 'has item elements' do
      Timecop.freeze(2010, 2, 7, 14, 4) do
        micropost = create(:micropost)
        body = MarkdownRenderer.to_html(micropost.body)

        get microposts_feed_url(format: :json)
        item = json[:items].first

        expect(item[:url]).to eq(micropost_ms_epoch_url(micropost.ms_epoch))
        expect(item[:content_html]).to eq(body)
        expect(item[:id]).to eq(micropost.guid)
        expect(item[:author][:name]).to eq('Edward Loveall')
        expect(item[:author][:url]).to eq(root_url)
        expect(item[:date_published]).to eq('2010-02-07T14:04:00+00:00')
      end
    end

    it 'returns a 304 when there are no new posts' do
      create(:micropost)

      get microposts_feed_url(format: :json)

      expect(response).to have_http_status(:ok)

      headers = { 'HTTP_IF_NONE_MATCH' => response.etag }
      get microposts_feed_url(format: :json), headers: headers

      expect(response).to have_http_status(:not_modified)
    end
  end

  def json
    @_json ||= JSON.parse(response.body).deep_symbolize_keys
  end
end
