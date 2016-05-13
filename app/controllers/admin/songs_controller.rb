class Admin::SongsController < AdminController
  def index
    @songs = Song.all
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to admin_songs_path
    else
      render :new
    end
  end

  def edit
    @song = find_song
  end

  def update
    @song = find_song
    if @song.update(song_params)
      redirect_to admin_songs_path
    else
      render :edit
    end
  end

  def destroy
    song = find_song
    if !song.destroy
      flash[:error] = t('flashes.song.delete.error')
    end
    redirect_to admin_songs_path
  end

  private

  def song_params
    params.require(:song).
           permit(:title, :audio, :description)
  end

  def find_song
    @song = Song.find(params[:id])
  end
end
