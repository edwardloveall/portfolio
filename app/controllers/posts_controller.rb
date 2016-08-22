class PostsController < ApplicationController
  layout 'blog'

  def index
    page = params[:page] || 1
    @posts = Post.newest_first.page(page).per(10)
  end

  def show
    @post = Post.find_by(slug: params[:slug])
  end
end
