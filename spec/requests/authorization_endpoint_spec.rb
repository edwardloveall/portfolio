require "rails_helper"
include Oath::Test::Helpers

RSpec.describe "Endpoint discovery" do
  describe "Authorization endpoint" do
    it "can be found as a <link> tag in the <head>" do
      get root_path

      page = Nokogiri::HTML(response.body)
      head = page.at("head")
      auth_link = head.xpath("link[@rel='authorization_endpoint']").first

      expect(auth_link).to be
      expect(auth_link[:rel]).to eq("authorization_endpoint")
      expect(auth_link[:href]).to eq(new_authorization_url)
    end
  end
end

RSpec.describe "Authorization redirection" do
  describe "Authorization endpoint" do
    it "redirects to the redirect_uri with a code and state" do
      sign_in(create(:user))
      state = "123456"
      code = "abcdef"
      allow(SecureRandom).to receive(:hex).and_return(code)
      redirect_uri = "https://service.com/callback"
      callback_params = "?state=#{state}&code=#{code}"
      authorization_count = Authorization.count

      post authorizations_path(
        me: "http://portfolio.com",
        redirect_uri: redirect_uri,
        response_type: "code",
        state: state,
        authorization: {
          client_id: "https://example.com/",
          scope: "create update delete undelete"
        }
      )

      expect(Authorization.count).to eq(authorization_count + 1)
      expect(response).to redirect_to(redirect_uri + callback_params)
    end

    it "connects the user to the authorization" do
      user = create(:user)
      sign_in(user)

      post authorizations_path(
        me: "http://portfolio.com",
        redirect_uri: "https://service.com/callback",
        response_type: "code",
        state: "123456",
        authorization: {
          client_id: "https://example.com/",
          scope: "create update delete undelete"
        }
      )
      authorization = Authorization.last

      expect(authorization.user).to eq(user)
    end
  end
end
