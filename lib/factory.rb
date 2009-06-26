module Factory
  module_function

  def create_device(user,params={})
    stuff = Device::SAMPLE_SDP_MAGIC_COMBO
    stuff.merge!( { :name => "#{Faker::Name.name}'s device" } )
    stuff.merge!(params)
    user.devices.create( stuff )
  end
  
  def create_user(params={})
    nick = Faker::Name.first_name.downcase
    User.create params.merge( :username => Faker::Name.name, :email => Faker::Internet.email, :nickname => nick, :subdomain => nick )
  end

  def create_admin(params={})
    create_user( params.merge( :role => 'admin' ) )
  end
end
