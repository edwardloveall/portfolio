require "rails_helper"

describe ExternalPostCreator do
  it "creates an ExternalPost" do
    params = request_params(attributes_for(:external_post))
    external_post_count = ExternalPost.count

    ExternalPostCreator.call(params)

    expect(ExternalPost.count).to eq(external_post_count + 1)
  end

  it "returns the created ExternalPost" do
    params = request_params(
      attributes_for(:external_post).merge({ title: "My Title" })
    )
    external_post_count = ExternalPost.count

    result = ExternalPostCreator.call(params)

    expect(result).to be_a(ExternalPost)
    expect(result.title).to eq("My Title")
  end

  context "if the ExternalPost is invalid" do
    it "returns the post with errors" do
      params = request_params(
        attributes_for(:external_post).merge({ title: nil })
      )

      result = ExternalPostCreator.call(params)

      expect(result.errors.messages).to include(title: ["can't be blank"])
    end
  end

  it "creates a related Post" do
    params = request_params(
      attributes_for(:external_post).merge({ title: "abcdefg" })
    )

    ExternalPostCreator.call(params)
    external_post = ExternalPost.find_by(title: "abcdefg")
    post = external_post.post

    expect(external_post.post).to be_a(Post)
  end

  def request_params(params)
    ActionController::Parameters.new(params).permit!
  end
end
