require 'rails_helper'

RSpec.describe 'Microblog requests' do
  describe 'POST #create' do
    context 'without a valid API key' do
      it 'returns an unauthorized status' do
        post api_microposts_path,
             params: { micropost: { body: 'hello' } }.to_json,
             headers: unauthorized_headers

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a valid API key' do
      it 'returns an created status' do
        post api_microposts_path,
             params: { micropost: { body: 'hello' } }.to_json,
             headers: authorized_headers

        expect(response).to have_http_status(:created)
      end
    end

    it 'returns a 201 created' do
      post api_microposts_path,
           params: { micropost: { body: 'hello' } }.to_json,
           headers: authorized_headers

      expect(response).to have_http_status(:created)
    end

    it 'creates a micropost' do
      count = Micropost.count

      post api_microposts_path,
           params: { micropost: { body: 'hello' } }.to_json,
           headers: authorized_headers

      expect(Micropost.count).to eq(count + 1)
    end

    it 'returns json for the micropost' do
      post api_microposts_path,
           params: { micropost: { body: 'hello' } }.to_json,
           headers: authorized_headers
      json = JSON.parse(response.body)['micropost']

      expect(json['body']).to eq('hello')
      expect(json['id']).to be
      expect(json['created_at']).to be
    end
  end

  describe 'GET #index' do
    it 'returns an array of microposts' do
      create_list(:micropost, 2)

      get api_microposts_path, headers: unauthorized_headers
      json = JSON.parse(response.body)

      expect(json['microposts']).to be_an(Array)
      json['microposts'].each do |micropost|
        expect(micropost['body']).to be
        expect(micropost['id']).to be
        expect(micropost['created_at']).to be
      end
    end

    it 'returns a 304 when there are no new microposts' do
      create_list(:micropost, 2)
      headers = unauthorized_headers
      get api_microposts_path, headers: headers
      headers['HTTP_IF_NONE_MATCH'] = response.etag

      get api_microposts_path, headers: headers

      expect(response).to have_http_status(:not_modified)
    end

    it 'returns a 200 when there are new microposts' do
      headers = unauthorized_headers
      create_list(:micropost, 2)
      get api_microposts_path, headers: headers
      headers['HTTP_IF_NONE_MATCH'] = response.etag
      create_list(:micropost, 2)

      get api_microposts_path, headers: headers

      expect(response).to have_http_status(:ok)
    end
  end

  def unauthorized_headers
    { 'Content-Type' => 'application/json' }
  end

  def authorized_headers(token: '12345')
    unauthorized_headers.merge('Authorization' => "Token token=#{token}")
  end
end
