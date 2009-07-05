class CampaignController < ApplicationController
  def index
    if has_subdomain?
    else
      
    end
  end

  def welcome
  end
  def script
  end
  def founder_message
  end
  def record
  end

  def setup_complete?
    @current_user.profile.subdomain
  end

  def syndicate
    render :type => 'text/json', :text => 'Hi there', :layout => false
  end
end
