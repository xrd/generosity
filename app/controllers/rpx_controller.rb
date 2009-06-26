require 'json' # make sure to install the json gem
require 'net/http'
require 'net/https'

class RpxController < ApplicationController

  skip_before_filter :authenticate

  def login_return
    u = URI.parse(RPXNOW_URL)
    req = Net::HTTP::Post.new(u.path)
    req.set_form_data({ 'token' => params[:token],
                        'apiKey' => API_KEY,
                        'format' => 'json'})
    
    http = Net::HTTP.new(u.host,u.port)
    http.use_ssl = true if u.scheme == 'https'
    res = http.request(req)
    
    json_resp = res.body
    json = JSON.parse(json_resp)
    
    if json['stat'] == 'ok'
      unique_identifier = json['profile']['identifier']
      nickname = json['profile']['preferredUsername']
      nickname = json['profile']['displayName'] if nickname.nil?
      email = json['profile']['email']
      photo_url = json['profile']['photo']
      
      # implement your own do_success method which signs the user in
      # to your website
      do_success(unique_identifier,email,nickname,photo_url)
      redirect_to root_path
    else
      flash[:notice] = 'Log in failed'
      redirect_to '/'
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def do_success(uid,email,nickname,photo)
    unless u = User.find_by_identifier(uid) # , :conditions => ['subdomain is not null'])
      u = User.create :username => nickname, :identifier => uid, :email => email, :nickname => nickname, :photo => photo
    end
    session[:user_id] = u.id if u
  end

  def login
    
  end

end
