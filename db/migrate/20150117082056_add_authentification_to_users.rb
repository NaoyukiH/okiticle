class AddAuthentificationToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :uid, :striing
  	add_column :users, :provider, :string
  	add_column :users, :token, :string

  	add_index :users, :uid
  	add_index :users, :provider
  	add_index :users, :token
  end
end
