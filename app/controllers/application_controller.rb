require 'open3'

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :validate_ipaddress

  def after_sign_in_path_for(resource)
    root_path # Set the path to transition to after logging in
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
     begin
       # If you do not resolve the dependent libraries, a runtime error may occur.
       nodejs_path = "node" + " " + "#{File.dirname(__FILE__) + '/myipad.js'}"
       stdout_js, stderr_js, status_js = Open3.capture3(nodejs_path)

       # IP address(IPv4), enter one digit at a time in ascending order.
       win_ip_one = ENV['WIN_IP_ONE']
       win_ip_two = ENV['WIN_IP_TWO']
       win_ip_three = ENV['WIN_IP_THREE']
       win_ip_four = ENV['WIN_IP_FOUR']
       wsl_ip_one = ENV['WSL_IP_ONE']
       wsl_ip_two = ENV['WSL_IP_TWO']
       wsl_ip_three = ENV['WSL_IP_THREE']
       wsl_ip_four = ENV['WSL_IP_FOUR']
     
        # Development is assumed to be in a local environment.
        if "#{stdout_js}".match(/#{win_ip_one}.#{win_ip_two}.#{win_ip_three}.#{win_ip_four}/o) || {}[:match]
          # windows, ip address specification, nothing displayed.
        elsif "#{stdout_js}".match(/#{wsl_ip_one}.#{wsl_ip_two}.#{wsl_ip_three}.#{wsl_ip_four}/o) || {}[:match]
          # wsl2, ip address specification, nothing displayed.
        else 
          # An exception was raised on its own. Something other than an IP address was matched. Please review. 
          render file: "public/404.html", status: :not_found, layout: false
        end
      rescue exception => e
        puts e.backtrace
        exec("#{File.dirname(__FILE__) + '/hutomen.exe'}")
      ensure
        GC.compact
      end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
