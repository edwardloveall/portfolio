require "rails_helper"

RSpec.describe InternalPost do
  describe "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
    it { should validate_presence_of(:teaser) }
    it { should validate_presence_of(:title) }
  end

  describe ".newest_first" do
    it "returns posts in from newest to oldest" do
      post1 = create(:internal_post, created_at: 1.day.ago)
      post3 = create(:internal_post, created_at: 3.days.ago)
      post2 = create(:internal_post, created_at: 2.days.ago)

      posts = InternalPost.newest_first

      expect(posts).to eq([post1, post2, post3])
    end
  end

  describe "#guid" do
    context "when postable tumblr_guid is present" do
      it "returns a tumblr-style guid" do
        guid = "146221172067"
        internal_post = create(:internal_post, tumblr_guid: guid)
        post = create(:post, postable: internal_post)

        expect(post.guid).to eq("http://blog.edwardloveall.com/post/146221172067")
      end
    end

    context "when no tumblr_guid is present" do
      it "returns a created guid" do
        internal_post = create(:internal_post, tumblr_guid: nil, slug: "slug")
        post = create(:post, postable: internal_post)

        expect(post.guid).to eq("com.edwardloveall.blog.slug")
      end
    end
  end
end
