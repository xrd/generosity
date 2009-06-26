# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c2e35e370a3af3722c0a1c4df84c4855'
  
  before_filter :setup
  before_filter :rpx_setup
  before_filter :authenticate

  private
  def setup
    get_user_id
    load_subdomain
  end

  def has_subdomain?
    false
  end

  def authenticate
    login_required
  end

  def get_user_id
    user_id = session[:user_id]
    if user_id
      @current_user = User.find_by_id user_id
    end
  end

  def login_required
    @current_user = User.first if ENV['DISABLE_RPX']
    redirect_to login_path unless @current_user
  end

  def unauthorized
    render :text => 'unauthorized'
  end

  def rpx_setup
    return true if ENV['DISABLE_RPX']
    unless Object.const_defined?(:API_KEY) && Object.const_defined?(:BASE_URL) && Object.const_defined?(:REALM)
      render :template => '/dashboard/invalid', :layout => false
      return false
    end
    @rpx = Rpx::RpxHelper.new(API_KEY, BASE_URL, REALM)
    return true
  end

  def verify_admin
    @current_user.admin?
  end

  def load_subdomain
    if request.env['SERVER_NAME']
      host = request.env['SERVER_NAME']
      @subdomain = host.gsub(GENEROSITY_BASE,"")
    end
  end
end
