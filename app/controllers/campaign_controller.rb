class CampaignController < ApplicationController
  def index
    if has_subdomain?
    else
      
    end
  end

  def why

  end

  def setup_complete?
    @current_user.profile.subdomain
  end
end
