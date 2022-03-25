require "rails_helper"

RSpec.describe InternalPost, type: :model do
  describe "validations" do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
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
end
