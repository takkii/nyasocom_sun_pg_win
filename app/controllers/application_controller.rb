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
  after_action :set_csrf_token_header
  before_action :set_locale
  before_action :recommender_circuit_check # ※1
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

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  private

  def validate_welcome
    begin
      card_name = ENV['CARD_NAME']
      memberscard = ENV['MEMBERS_CARD']
      member = File.expand_path(memberscard + card_name)
      eq_pass = ENV['EQUAL_PASSWORD']

      unless File.exist?(member)
        puts 'Not found ' + card_name.to_s + ', Exec tanraku.'
        tanraku_execute
      else
        File.open(member) do |f|
          while (name = f.gets)
            name_c = name.chomp
              unless name_c =~ /#{eq_pass}/o
                puts 'No, Match Word in ' + card_name.to_s
                exit!
              else
                puts "Match word contain #{eq_pass} in #{card_name}"
                return
              end
          end
          if f.eof?
            f.close
          elsif !f.eof
            tanraku_execute
          end
        end
      end
    rescue StandardError => a
      puts a.backtrace
      tanraku_execute
    ensure
      GC.auto_compact
    end
  end

  # BrokenCircuit
  def recommender_circuit_check
    @num_failure = ENV['FAILURE_NUMBER']
    @within = ENV['WITHIN ']
    @failure = [].to_s

    if @failure >= @num_failure.to_s
      cutoff = Time.now - @within.to_i
      @failure.split.reject!{|t| t < cutoff.to_s}
      return if @failure.length >= @num_failure.to_i
    end

    begin
      yield
    rescue
      @failure.to_i << (Time.now).to_i
      nil
    end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
