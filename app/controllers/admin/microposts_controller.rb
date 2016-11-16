class Admin::MicropostsController < AdminController
  def new
    @micropost = Micropost.new
    @microposts = Micropost.all
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
