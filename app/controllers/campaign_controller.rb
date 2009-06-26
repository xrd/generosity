class CampaignController < ApplicationController
  def index
    if has_subdomain?
      
    else
      render :template => 'campaign/whyareyouhere'
    end
  end

  def setup_complete?
    @current_user.profile.subdomain
  end
end
