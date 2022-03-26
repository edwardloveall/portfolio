class InternalPostsController < ApplicationController
  layout "blog"

  def show
    @internal_post = InternalPost.find_by(slug: params[:slug])
  end
end
