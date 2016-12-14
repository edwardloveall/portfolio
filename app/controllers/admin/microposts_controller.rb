class Admin::MicropostsController < AdminController
  PER_PAGE = 30

  def new
    @micropost = Micropost.new
    @microposts = Micropost.newest_first.page(1).per(PER_PAGE)
  end

  def create
    @micropost = Micropost.create(micropost_params)
    redirect_to new_admin_micropost_path
  end

  def edit
    @micropost = Micropost.find(params[:id])
  end

  def update
    @micropost = Micropost.find(params[:id])
    if @micropost.update(micropost_params)
      redirect_to new_admin_micropost_path
    else
      render :edit
    end
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.destroy
    redirect_to new_admin_micropost_path
  end

  def micropost_params
    params.require(:micropost).permit(:body)
  end
end
