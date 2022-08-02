class AddPositionToSongs < ActiveRecord::Migration[4.2]
  def change
    add_column :songs, :position, :integer
  end
end
