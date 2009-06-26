class AddRpxToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :identifier, :string
    add_column :users, :username, :string
    add_column :users, :nickname, :string
    add_column :users, :photo, :string
  end

  def self.down
    remove_column :users, :identifier, :nickname, :username, :photo
  end

end
