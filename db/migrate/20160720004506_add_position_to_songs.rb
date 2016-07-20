class AddPositionToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :position, :integer
  end
end
