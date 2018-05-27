require "rails_helper"

RSpec.describe "microblog token endpoint" do
  describe "token creation endpoint" do
    it "routes POST /tokens to tokens#create" do
      token_creation = { controller: "tokens", action: "create" }

      expect(post: "/tokens").to route_to(token_creation)
    end
  end

  describe "token verification endpoint" do
    it "routes GET /tokens to tokens#verify" do
      token_verification = { controller: "tokens", action: "verify" }

      expect(get: "/tokens").to route_to(token_verification)
    end
  end
end
