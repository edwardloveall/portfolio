require "rails_helper"

RSpec.describe "Endpoint discovery" do
  describe "Micropub endpoint" do
    it "can be found as a <link> tag in the <head>" do
      get root_path

      page = Nokogiri::HTML(response.body)
      head = page.at("head")
      micropub_link = head.xpath("link[@rel='micropub']").first

      expect(micropub_link).to be
      expect(micropub_link[:rel]).to eq("micropub")
      expect(micropub_link[:href]).to eq(api_micropubs_url)
    end
  end
end
