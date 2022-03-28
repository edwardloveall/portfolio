require "rails_helper"

describe Post do
  it { should belong_to(:postable) }
  it { should delegate_method(:created_at).to(:postable) }
  it { should delegate_method(:updated_at).to(:postable) }
  it { should delegate_method(:guid).to(:postable) }

  describe ".newest_first" do
    it "returns postable objects from newest to oldest" do
      ep1 = create(:external_post, posted_on: 4.day.ago)
      ip3 = create(:internal_post, created_at: 3.days.ago)
      ip1 = create(:internal_post, created_at: 1.day.ago)
      ip2 = create(:internal_post, created_at: 2.days.ago)
      post4 = create(:post, postable: ep1)
      post3 = create(:post, postable: ip3)
      post1 = create(:post, postable: ip1)
      post2 = create(:post, postable: ip2)

      posts = Post.newest_first

      expect(posts).to eq([post1, post2, post3, post4])
    end
  end
end
