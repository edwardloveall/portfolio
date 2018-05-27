require "rails_helper"

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

        post tokens_path, params: params, headers: headers
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

        post tokens_path, params: params, headers: headers
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
