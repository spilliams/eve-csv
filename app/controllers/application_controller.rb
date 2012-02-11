class ApplicationController < ActionController::Base
  protect_from_forgery
  
  prepend_before_filter :authenticate_user!
  
  before_filter do
    @api = Eve::API.new
    @api = current_user.api unless current_user.nil?
  end
end
