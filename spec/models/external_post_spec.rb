require "rails_helper"

RSpec.describe ExternalPost do
  describe "associations" do
    it { should have_one(:post) }
  end

  describe "validations" do
    it { should validate_presence_of(:posted_on) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:teaser) }
    it { should validate_presence_of(:url) }
  end

  describe ".newest_first" do
    it "returns posts in from newest to oldest" do
      post1 = create(:external_post, posted_on: 1.day.ago)
      post3 = create(:external_post, posted_on: 3.days.ago)
      post2 = create(:external_post, posted_on: 2.days.ago)

      posts = ExternalPost.newest_first

      expect(posts).to eq([post1, post2, post3])
    end
  end

  describe "#guid" do
    it "is the same as URL" do
      post = build(:external_post, url: "foo")

      expect(post.guid).to eq("foo")
    end
  end
end
