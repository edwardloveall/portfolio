require "rails_helper"

describe InternalPostCreator do
  it "creates an InternalPost" do
    params = request_params(attributes_for(:internal_post))
    internal_post_count = InternalPost.count

    InternalPostCreator.call(params)

    expect(InternalPost.count).to eq(internal_post_count + 1)
  end

  it "returns the created InternalPost" do
    params = request_params(
      attributes_for(:internal_post).merge({ title: "My Title" })
    )
    internal_post_count = InternalPost.count

    result = InternalPostCreator.call(params)

    expect(result).to be_a(InternalPost)
    expect(result.title).to eq("My Title")
  end

  context "if the InternalPost is invalid" do
    it "returns the post with errors" do
      params = request_params(
        attributes_for(:internal_post).merge({ title: nil })
      )

      result = InternalPostCreator.call(params)

      expect(result.errors.messages).to include(title: ["can't be blank"])
    end
  end

  it "creates a related Post" do
    params = request_params(
      attributes_for(:internal_post).merge({ slug: "my-slug" })
    )

    InternalPostCreator.call(params)
    internal_post = InternalPost.find_by(slug: "my-slug")
    post = internal_post.post

    expect(internal_post.post).to be_a(Post)
  end

  def request_params(params)
    ActionController::Parameters.new(params).permit!
  end
end
