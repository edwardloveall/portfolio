class InternalPostDestroyer
  def self.call(internal_post)
    new.call(internal_post)
  end

  def call(internal_post)
    internal_post.transaction do
      internal_post.post.destroy
      internal_post.destroy
    end
  end
end
