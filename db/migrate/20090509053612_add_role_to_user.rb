class AddRoleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :role, :string
    User.all.each do |u|
      u.update_attribute( :role, 'admin') if u.nickname.eql? "xrdawson" or u.nickname.eql? 'podslug'
    end
  end

  def self.down
    remove_column :users, :role
  end
end
