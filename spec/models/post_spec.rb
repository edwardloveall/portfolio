require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:slug) }
    it { should validate_uniqueness_of(:slug) }
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

  describe '#guid' do
    context 'when tumblr_guid is present' do
      it 'returns a tumblr-style guid' do
        guid = '146221172067'
        post = create(:post, tumblr_guid: guid)

        expect(post.guid).to eq('http://blog.edwardloveall.com/post/146221172067')
      end
    end

    context 'when no tumblr_guid is present' do
      it 'returns a created guid' do
        post = create(:post)

        expect(post.guid).to eq("com.edwardloveall.blog.#{post.slug}")
      end
    end
  end
end
