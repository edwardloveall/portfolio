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
  end
end
