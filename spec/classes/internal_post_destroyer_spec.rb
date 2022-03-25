require "rails_helper"

describe InternalPostDestroyer do
  it "destroys an InternalPost" do
    post = create(:post)
    internal_post = post.postable
    internal_post_count = InternalPost.count

    InternalPostDestroyer.call(internal_post)

    expect(InternalPost.count).to eq(internal_post_count - 1)
  end

  it "destroys the related Post" do
    post = create(:post)
    internal_post = post.postable
    post_count = Post.count

    InternalPostDestroyer.call(internal_post)

    expect(Post.count).to eq(post_count - 1)
  end
end
