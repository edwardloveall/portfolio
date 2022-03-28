class Admin::ExternalPostsController < AdminController
  def index
    @external_posts = ExternalPost.all
  end

  def new
    @external_post = ExternalPost.new
  end

  def create
    @external_post = ExternalPostCreator.call(external_post_params)

    if @external_post.persisted?
      redirect_to(
        admin_external_posts_path,
        notice: "External post successfully created."
      )
    else
      render :new
    end
  end

  def edit
    @external_post = find_external_post
  end

  def update
    @external_post = find_external_post

    if @external_post.update(external_post_params)
      redirect_to(
        admin_external_posts_path,
        notice: "External post successfully updated."
      )
    else
      render :edit
    end
  end

  def destroy
    ExternalPostDestroyer.call(find_external_post)
    redirect_to(
      admin_external_posts_path,
      notice: "External post was successfully destroyed."
    )
  end

  private

  def external_post_params
    params.require(:external_post).permit(:posted_on, :teaser, :title, :url)
  end

  def find_external_post
    ExternalPost.find(params[:id])
  end
end
