class MicropostsController < ApplicationController
  def feed
    @microposts = Micropost.all
    render :feed, formats: [:rss]
  end

  def index
    @microposts = Micropost.all
  end

  def show
    @micropost = Micropost.find_by(ms_epoch: params[:ms_epoch])
  end
end
