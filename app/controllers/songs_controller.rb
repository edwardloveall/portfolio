class SongsController < ApplicationController
  def index
    @songs = Song.by_position
  end

  def show
    @song = Song.find(params[:id])
  end
end
