class AddTokenToAuthorization < ActiveRecord::Migration[5.0]
  def change
    add_column :authorizations, :token, :string
    add_column :authorizations, :token_expires_at, :datetime
  end
end
