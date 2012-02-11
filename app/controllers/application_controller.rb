class ApplicationController < ActionController::Base
  protect_from_forgery
  
  prepend_before_filter :authenticate_user!
  
  # GET /
  def index
    
  end
end
