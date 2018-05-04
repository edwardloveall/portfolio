require 'rails_helper'

RSpec.describe "Endpoint discovery" do
  describe "auth endpoint" do
    it "can be found as a <link> tag in the <head>" do
      get root_path

      page = Nokogiri::HTML(response.body)
      head = page.at("head")
      auth_link = head.xpath("link[@rel='authorization_endpoint']").first

      expect(auth_link).to be
      expect(auth_link[:rel]).to eq("authorization_endpoint")
      expect(auth_link[:href]).to eq(auth_url)
    end

    it "redirects to the redirect_uri with a code and state" do
      state = "123456"
      code = "abcdef"
      callback = "https://example.com/callback"
      redirect_url = "#{callback}?state=#{state}&code=#{code}"
      get auth_url(
        me: "https://edwardloveall.com",
        redirect_uri: callback,
        client_id: "https://example.com/",
        state: state,
        scope: "create update delete undelete",
        response_type: "code"
      )
      uri = URI(response.location)
      params = Rack::Utils.parse_query(uri.query)

      expect(response).to redirect_to(%r(#{callback}))
      expect(params).to be_key("state")
      expect(params).to be_key("code")
      expect(params["state"]).to eq(state)
    end
  end
end
