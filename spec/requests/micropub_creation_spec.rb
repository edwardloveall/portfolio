require "rails_helper"

RSpec.describe "Creating an h-entry post" do
  context "when the Content-type is form encoded" do
    it "creates a micropost" do
      auth = create(:authorization)
      auth.generate_token!
      headers = {
        "Authorization" => "Bearer #{auth.token}",
        "Content-type" => "application/x-www-form-urlencoded; charset=utf-8"
      }
      body = {
        h: "entry",
        content: "Micropub test of creating a basic h-entry"
      }
      micropost_count = Micropost.count

      post api_micropubs_path, params: body, headers: headers

      expect(Micropost.count).to eq(micropost_count + 1)
      expect(response).to have_http_status(:created)
      path_matcher = %r(#{microposts_path}/\d+)
      expect(response.headers["Location"]).to match(path_matcher)
    end
  end
end
