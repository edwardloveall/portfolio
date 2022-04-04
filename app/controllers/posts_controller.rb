class PostsController < ApplicationController
  layout "blog"

  def index
    @posts = Post.newest_first

    respond_to do |format|
      format.html
      format.rss do
        @posts = @posts.first(10)
        render :index, layout: nil
      end
    end
  end
end
