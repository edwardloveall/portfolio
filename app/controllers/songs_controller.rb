class SongsController < ApplicationController
  def index
    @songs = Song.
      includes(mp3_attachment: :blob).
      includes(ogg_attachment: :blob).
      by_position
  end

  def show
    @song = Song.find(params[:id])
  end
end
