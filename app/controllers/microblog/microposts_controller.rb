class Microblog::MicropostsController < MicroblogController
  def feed
    @microposts = Micropost.all
    render :feed, formats: [:rss]
  end
end
