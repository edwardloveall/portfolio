require "rails_helper"

describe Post do
  it { should belong_to(:postable) }
  it { should delegate_method(:created_at).to(:postable) }

  describe ".newest_first" do
    it "returns postable objects from newest to oldest" do
      ip3 = create(:internal_post, created_at: 3.days.ago)
      ip1 = create(:internal_post, created_at: 1.day.ago)
      ip2 = create(:internal_post, created_at: 2.days.ago)
      post3 = create(:post, postable: ip3)
      post1 = create(:post, postable: ip1)
      post2 = create(:post, postable: ip2)

      posts = Post.newest_first

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
