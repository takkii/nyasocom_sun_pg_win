require 'csv'
require 'open3'
require 'open-uri'
require 'nokogiri'
require 'sanitize'
require 'socket'
require 'tanraku'

class Net::HTTP
  def initialize_new(address, port = nil)
    initialize_old(address, port)
    @read_timeout = 900 # timeout, 15 minute settings.
  end
  alias :initialize_old :initialize
  alias :initialize :initialize_new
end

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_action :validate_ipaddress # ※1
  before_action :validate_memberscard # ※1
  before_action :validate_welcome # ※1

  # ※1 If not use, head position is comment add.

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
      # Change, Can do customize naming to memberscard.
      memberscard = './pass.txt'.to_s
      member = File.expand_path(memberscard)

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
                # Input, secret word in memberscard.
                f.puts <<-DOC
TRUE
                DOC
              end
              # passed, Match word contain in csv file.
              puts "Created, #{memberscard}"
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
        puts 'Pass, memberscard checked.'
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
      # Text file reading directly below under this project.
      member = File.expand_path('./pass.txt')
      # Check, that two strings are equal.
      eq_str = 'TRUE'.to_s

      unless File.exist?(member)
        puts 'Do not have members card, Exec tanraku.'
        tanraku_execute
      else
        open(member) do |f|
          while (name = f.readlines)
            name.sort!
            name.each do |str_n|
            unless "#{str_n}" =~ /#{eq_str}/o
              puts "#{str_n}"
              puts 'No, Match Word in members card.'
              exit!
            else
              puts "Match word contain #{eq_str} in members card."
              return
            end
          end
        end
      end
    end
    rescue StandardError=> a
      puts a.backtrace
    ensure
      GC.auto_compact
    end
  end

  def my_address
    udp = UDPSocket.new
    udp.connect("128.0.0.0", 7)
    adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
    udp.close
    adrs
  end

  def validate_ipaddress
    begin
      ip_add = "#{request.env['HTTP_CLIENT_IP']}"
      # Development is assumed to be in a local environment.
      unless "#{my_address}" =~ /#{ip_add}/o
        puts "#{my_address} | #{ip_add}"
        puts 'Something other than an IP address was matched.'
        exit!
      else
        puts 'Passed, ip address specification.'
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
