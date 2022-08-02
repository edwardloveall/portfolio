class AddPositionToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :position, :integer
  end
end
