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
     local_ip = AllowedSource.all
     nodejs_path = "node" + " " + "#{File.dirname(__FILE__) + '/myipad.js'}"
     stdout_js, stderr_js, status_js = Open3.capture3(nodejs_path)

     unless "#{stdout_js}".match(/^10\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$|^172\.(1[6-9]|2[0-9]|3[0-1])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$|^192\.168\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$/o) || {}[:match]
     	raise MyError, "An exception was raised on its own. Something other than an IP address was matched. Please review." 
     end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
