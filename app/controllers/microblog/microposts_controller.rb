class Microblog::MicropostsController < MicroblogController
  def feed
    @microposts = Micropost.all
    render :feed, formats: [:rss]
  end

  def index
    @microposts = Micropost.all
  end

  def show
    microseconds = params[:timestamp].to_f
    timestamp = microseconds / 1_000_000
    date = Time.zone.at(timestamp)

    @micropost = Micropost.find_by(created_at: date)
  end
end
