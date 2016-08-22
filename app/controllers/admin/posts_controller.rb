class Admin::PostsController < AdminController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
    @post = find_post
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    @post = find_post
    if @post.update(post_params)
      redirect_to admin_posts_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post = find_post
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :slug)
  end

  def find_post
    Post.find(params[:id])
  end
end
