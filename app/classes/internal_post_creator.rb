class InternalPostCreator
  def self.call(params)
    new.call(params)
  end

  def call(params)
    InternalPost.transaction do
      InternalPost.create(params).tap do |internal_post|
        Post.create(postable: internal_post)
      end
    end
  end
end
