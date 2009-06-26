class AddUserAndVariables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
    end

    create_table :variables do |t|
      t.integer :user_id
      t.string :name, :text
    end

  end

  def self.down
    drop_table :users, :variables
  end
end
