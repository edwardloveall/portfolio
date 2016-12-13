class Api::MicropostsController < ApiController
  before_action :authenticate, only: :create

  def index
    @microposts = Micropost.newest_first
    fresh_when(@microposts)
  end

  def create
    @micropost = Micropost.create(micropost_params)
    render status: :created
  end

  private

  def micropost_params
    params.require(:micropost).permit(:body)
  end
end
