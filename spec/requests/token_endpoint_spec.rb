require "rails_helper"

RSpec.describe "Endpoint discovery" do
  describe "Token endpoint" do
    it "can be found as a <link> tag in the <head>" do
      get root_path

      page = Nokogiri::HTML(response.body)
      head = page.at("head")
      token_link = head.xpath("link[@rel='token_endpoint']").first

      expect(token_link).to be
      expect(token_link[:rel]).to eq("token_endpoint")
      expect(token_link[:href]).to eq(tokens_url)
    end
  end
end

RSpec.describe "Requesting an initial token" do
  context "if a valid authorization exists" do
    context "if the accept header is set to JSON" do
      it "returns a token" do
        me = "https://example.com"
        user = create(:user, me: me)
        auth = create(:authorization, user: user)
        params = {
          code: auth.code,
          me: me,
          redirect_uri: "#{auth.client_id}/callback",
          client_id: auth.client_id
        }
        headers = { "Accept" => "application/json" }

        with_forgery_protection do
          post tokens_path, params: params, headers: headers
        end
        data = JSON.parse(response.body)

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
        expect(data["access_token"]).to be
        expect(data["scope"]).to be
        expect(data["me"]).to eq(me)
      end
    end

    context "if the accept header is set to form encoded" do
      it "returns a token" do
        me = "https://example.com"
        user = create(:user, me: me)
        auth = create(:authorization, user: user)
        params = {
          code: auth.code,
          me: me,
          redirect_uri: "#{auth.client_id}/callback",
          client_id: auth.client_id
        }
        headers = { "Accept" => "application/x-www-form-urlencoded" }

        with_forgery_protection do
          post tokens_path, params: params, headers: headers
        end
        data = Hash[URI.decode_www_form(response.body)]

        expect(response.content_type).to eq("application/x-www-form-urlencoded")
        expect(response).to have_http_status(:ok)
        expect(data["access_token"]).to be
        expect(data["scope"]).to be
        expect(data["me"]).to eq(me)
      end
    end
  end
end

RSpec.describe "Verifying an existing token" do
  context "if a valid authorization token exists" do
    context "if the accept header is set to JSON" do
      it "returns token details" do
        me = "https://example.com"
        user = create(:user, me: me)
        auth = create(:authorization, user: user)
        auth.generate_token!
        headers = {
          "Authorization" => "Bearer #{auth.token}",
          "Accept" => "application/json"
        }

        get verify_tokens_path, headers: headers
        data = JSON.parse(response.body)

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)
        expect(data["client_id"]).to be
        expect(data["scope"]).to eq(auth.scope)
        expect(data["me"]).to eq(me)
      end
    end

    context "if the accept header is set to form encoded" do
      it "returns token details" do
        me = "https://example.com"
        user = create(:user, me: me)
        auth = create(:authorization, user: user)
        auth.generate_token!
        headers = {
          "Authorization" => "Bearer #{auth.token}",
          "Accept" => "application/x-www-form-urlencoded"
        }

        get verify_tokens_path, headers: headers
        data = Hash[URI.decode_www_form(response.body)]

        expect(response.content_type).to eq("application/x-www-form-urlencoded")
        expect(response).to have_http_status(:ok)
        expect(data["client_id"]).to be
        expect(data["scope"]).to eq(auth.scope)
        expect(data["me"]).to eq(me)
      end
    end
  end
end
