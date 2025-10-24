require 'grouse'
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
      memberscard = ENV['MEMBERS_CARD']
      member = File.expand_path(memberscard)
      secretword = ENV['SECRET_WORD']
      hyoka_url = ENV['HYOKAPROJECT_URL']

      unless File.exist?(member)
        while true do
          html = URI.open(hyoka_url).read
          doc = Nokogiri::HTML.parse(html)
          doc_h1 = doc.at_css('h1')
          elements = Sanitize.clean(doc_h1).to_s
          ng_word = '❎'

          unless elements =~ /#{ng_word}/o
            File.open(member, 'a:utf-8', perm = 0o777) do |f|
              f.puts <<-DOC
#{secretword}
              DOC
            end
            # passed, hyoka accuary number is normal.
            puts "Created, #{secretword} writed to #{memberscard}"
            return
          else
            # misstake, hyoka accuary number is unusual.
            puts '❎, contain message, exec tanraku_execute.'
            tanraku_execute
          end
          redirect_to root_path
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
      memberscard = ENV['MEMBERS_CARD']
      member = File.expand_path(memberscard)
      eq_pass = ENV['EQUAL_PASSWORD']

      unless File.exist?(member)
        puts 'Do not have members card, Exec tanraku.'
        tanraku_execute
      else
        open(member) do |f|
          while (name = f.readlines)
            name.sort!
            name.each do |pass_n|
              unless "#{pass_n}" =~ /#{eq_pass}/o
                puts "#{pass_n}"
                puts 'No, Match Word in members card.'
                exit!
              else
                puts "Match word contain #{eq_pass} in memberscard."
                return
              end
            end
          end
        end
      end
    rescue StandardError => a
      puts a.backtrace
    ensure
      GC.auto_compact
    end
  end

  def validate_ipaddress
    begin
      unless "#{udp_socket}" == "#{list_socket}"
        puts "#{udp_socket} | #{list_socket}"
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
