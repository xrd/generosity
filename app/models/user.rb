class User < ActiveRecord::Base
  def admin?
    self.role.eql? 'admin'
  end
end
