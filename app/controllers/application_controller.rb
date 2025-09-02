require 'csv'
require 'open3'

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :validate_ipaddress
  before_action :validate_justice

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

  def validate_justice
    begin
      # Once Run scriping.py, no match ReStart Server.
      python_path = "python" + " " + "#{File.dirname(__FILE__) + '/scriping.py'}"
      stdout_py, stderr_py, status_py = Open3.capture3(python_path)

      # xxx_utf8.csv (default)
      unless File.exist?("./pass.txt")
        CSV.foreach('./config/xxx_utf8.csv') do |xxx_csv|
          if "#{stdout_py}".match(/#{xxx_csv}/o) || {}[:match]
            mypass = File.expand_path('./pass.txt')
            File.open(myhome, 'a:utf-8', perm = 0o777) do |f|
              f.puts <<-DOC
TRUE
              DOC
            end
            puts 'Created, ./pass.txt'
          # passed, word match in csv file
          else
            # Something other than an not xxx_utf8.csv file was matched.
          end
        end
        puts 'None, pass.txt not created.'
      end
    rescue exception => ex
      puts ex.backtrace
      exec("#{File.dirname(__FILE__) + '/hutomen.exe'}")
    ensure
      GC.compact
    end
  end

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
        # Passed, ip address specification, nothing displayed.
      else
        # Something other than an IP address was matched.
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
