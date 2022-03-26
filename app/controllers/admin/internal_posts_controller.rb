class Admin::InternalPostsController < AdminController
  def index
    @internal_posts = InternalPost.newest_first
  end

  def new
    @internal_post = InternalPost.new
  end

  def edit
    @internal_post = find_internal_post
  end

  def create
    @internal_post = InternalPostCreator.call(internal_post_params)

    if @internal_post.persisted?
      redirect_to(
        admin_internal_posts_path,
        notice: "Internal post successfully created."
      )
    else
      render :new
    end
  end

  def update
    @internal_post = find_internal_post
    if @internal_post.update(internal_post_params)
      redirect_to(
        admin_internal_posts_path,
        notice: "Internal post successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    InternalPostDestroyer.call(find_internal_post)
    redirect_to(
      admin_internal_posts_path,
      notice: "Internal post was successfully destroyed."
    )
  end

  private

  def internal_post_params
    params.require(:internal_post).permit(:body, :slug, :teaser, :title)
  end

  def find_internal_post
    InternalPost.find(params[:id])
  end
end
