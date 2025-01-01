require 'open3'

class ApplicationController < ActionController::Base
  before_action ->{
   :set_locale
   :validate_ipaddress
  }

  def after_sign_in_path_for(resource)
    #root_path # Set the path to transition to after logging in
    new_two_step_verification_path
  end

  def after_sign_out_path_for(resource)
    root_path # Set the path to transition to after logging out
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def raise_not_found!
    e = ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    render_404(e)
  end

  private

  def validate_ipaddress
     nodejs_path = "node" + " " + "#{File.dirname(__FILE__) + '/myipad.js'}"
     stdout_js, stderr_js, status_js = Open3.capture3(nodejs_path)
     # When the server is running, only a few permissions are granted.
     ip_match = ENV['IPADDRESS_USER']
     
     # Development is assumed to be in a local environment.
     unless "#{stdout_js}".match( /#{ip_match}/o) || {}[:match]
     	raise MyError, "An exception was raised on its own. Something other than an IP address was matched. Please review." 
     end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
