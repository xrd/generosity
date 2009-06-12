class CampaignController < ApplicationController
  def index
    setup unless setup_complete?
  end

  def setup
    render :text => 'Setup'
  end

  def setup_complete?
    
  end
end
