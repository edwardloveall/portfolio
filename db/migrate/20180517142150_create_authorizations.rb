class CreateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :authorizations do |t|
      t.timestamps
      t.string :client_id, null: false
      t.string :scope
      t.string :code
      t.datetime :code_expires_at
    end
  end
end
