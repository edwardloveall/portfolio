class ExternalPostCreator
  def self.call(params)
    new.call(params)
  end

  def call(params)
    ExternalPost.transaction do
      ExternalPost.create(params).tap do |external_post|
        Post.create(postable: external_post)
      end
    end
  end
end
