class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :google_maps_apikey
  
  private

  def google_maps_apikey
    raise "APIKEY env variable not defined" if ENV['GOOGLE_API_KEY'].nil?
    @googleAPiKey = ENV['GOOGLE_API_KEY']
  end
end
