class AddOggToSongs < ActiveRecord::Migration
  def change
    add_attachment :songs, :ogg
  end
end
