require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
  end

  describe '.newest_first' do
    it 'returns posts in from newest to oldest' do
      post_a = create(:post, created_at: 1.day.ago)
      post_b = create(:post, created_at: 3.days.ago)
      post_c = create(:post, created_at: 2.days.ago)

      posts = Post.newest_first

      expect(posts).to eq([post_a, post_c, post_b])
    end
  end
end
