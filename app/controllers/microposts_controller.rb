class MicropostsController < ApplicationController
  PER_PAGE = 30
  layout 'microblog'

  def feed
    page = params[:page] || 1
    @microposts = Micropost.newest_first.page(page).per(PER_PAGE)
    render :feed, formats: [:rss]
  end

  def index
    page = params[:page] || 1
    @microposts = Micropost.newest_first.page(page).per(PER_PAGE)
  end

  def show
    @micropost = Micropost.find_by(ms_epoch: params[:ms_epoch])
  end
end
