class ExternalPostDestroyer
  def self.call(external_post)
    new.call(external_post)
  end

  def call(external_post)
    external_post.transaction do
      external_post.post.destroy
      external_post.destroy
    end
  end
end
