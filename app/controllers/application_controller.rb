require 'csv'
require 'open3'
require 'open-uri'
require 'nokogiri'
require 'sanitize'
require 'tanraku'

class Net::HTTP
  def initialize_new(address, port = nil)
    initialize_old(address, port)
    @read_timeout = 900 # timeoutを15分に変更
  end
  alias :initialize_old :initialize
  alias :initialize :initialize_new
end

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :validate_ipaddress
  before_action :validate_memberscard
  before_action :validate_welcome # If not use, head position is comment add.

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

  def validate_memberscard
    begin
      member = File.expand_path('./pass.txt')

      unless File.exist?(member)
        while true do
          html = URI.open('http://localhost:8000/hyokapp/').read
          doc = Nokogiri::HTML.parse(html)
          doc_h1 = doc.at_css('h1')
          elements = Sanitize.clean(doc_h1).parse_csv
          xxx_utf8 = './config/xxx_utf8.csv'

          CSV.foreach(xxx_utf8) do |xxx_csv|
            if (elements).to_s.match(/#{xxx_csv}/o) || {}[:match]
              File.open(member, 'a:utf-8', perm = 0o777) do |f|
                f.puts <<-DOC
TRUE
                DOC
              end
              # passed, Match word contain in csv file.
              puts 'Created, ./pass.txt'
              return
            else
              # Something other than an not xxx_utf8.csv file was matched.
              exit!
            end
              redirect_to root_path
          end
            break
        end
      else
        puts 'Check, members card process.'
        return
      end
    rescue Exception => e
      puts e.backtrace
    ensure
      GC.auto_compact
    end
  end

  def validate_welcome
    begin
      member = File.expand_path('./pass.txt')
      eq_str = 'TRUE'.to_s

      unless File.exist?(member)
        puts 'Do not have members card, Exec tanraku.'
        tanraku_execute
      else
        aqua_cmd = "aqua" + " " + "-t" + " " + member + " " + eq_str
        stdout_aq, stderr_aq, status_aq = Open3.capture3(aqua_cmd)

        # stdout_aq, 1 : TRUE
        unless "#{stdout_aq}".match(/#{eq_str}/o) || {}[:match]
          puts 'No, Match Word in members card.'
          exit!
        else
          puts "Match word contain #{eq_str} in members card."
          return
        end
      end
    rescue StandardError=> a
      puts a.backtrace
    ensure
      GC.auto_compact
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
        puts 'Passed, ip address specification.'
      else
        puts 'Something other than an IP address was matched.'
        exit!
      end
    rescue StandardError => s
      puts s.backtrace
    ensure
      GC.auto_compact
    end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
