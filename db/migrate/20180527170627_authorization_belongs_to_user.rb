class AuthorizationBelongsToUser < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :authorizations, :user
  end
end
