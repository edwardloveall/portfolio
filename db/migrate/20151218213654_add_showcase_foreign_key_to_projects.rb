class AddShowcaseForeignKeyToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :showcase, foreign_key: true, index: true
  end
end
