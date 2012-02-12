class DashboardController < ApplicationController
  # GET /
  def root
    redirect_to dashboard_index_path
  end

  # GET dashboard/index
  def index
    
  end
end