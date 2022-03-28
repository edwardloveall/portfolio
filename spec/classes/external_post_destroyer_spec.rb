require "rails_helper"

describe ExternalPostDestroyer do
  it "destroys an ExternalPost" do
    post = create(:post, :external)
    external_post = post.postable
    external_post_count = ExternalPost.count

    ExternalPostDestroyer.call(external_post)

    expect(ExternalPost.count).to eq(external_post_count - 1)
  end

  it "destroys the related Post" do
    post = create(:post, :external)
    external_post = post.postable
    post_count = Post.count

    ExternalPostDestroyer.call(external_post)

    expect(Post.count).to eq(post_count - 1)
  end
end
