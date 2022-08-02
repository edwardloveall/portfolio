class AddOggToSongs < ActiveRecord::Migration[4.2]
  def change
    add_attachment :songs, :ogg
  end
end
