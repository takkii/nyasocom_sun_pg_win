# frozen_string_literal: true

require 'grouse'
require 'tanraku'

class Net::HTTP
  def initialize_new(address, port = nil)
    initialize_old(address, port)
    @read_timeout = 900 # timeout, 15 minute settings.
  end

    # BrokenCircuit in grouse.
  def circuit_check
    recommender_circuit(ENV['FAILURE_NUMBER'], ENV['WITHIN'])
  end

  alias :initialize_old :initialize
  alias :initialize :initialize_new
  alias :initialize_new :circuit_check
end

class ApplicationController < ActionController::Base
  after_action :set_csrf_token_header
  before_action :set_locale
  before_action :validate_ipaddress      # ※1
  before_action :face_recognition_result # ※1

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

  def face_recognition_result
    validation_check(ENV['CARD_NAME'], ENV['MEMBERS_CARD'], ENV['EQUAL_PASSWORD'])
  end

  def validate_ipaddress
    ipaddress_certification(udp_socket, list_socket)
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
