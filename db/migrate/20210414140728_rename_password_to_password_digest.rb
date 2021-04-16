class RenamePasswordToPasswordDigest < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :password, :password_digest
    rename_column :users, :username, :email
  end
end
