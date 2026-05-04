# frozen_string_literal: true

require 'grouse'

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
  before_action :face_recognition_result # private functions.
  before_action :circuit_check # private functions.

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

  # Use, effect.txt in hyokaproject.
  def face_recognition_result
    validation_check(ENV['CARD_NAME'], ENV['MEMBERS_CARD'], ENV['EQUAL_PASSWORD'])
  end

  # BrokenCircuit in grouse.
  def circuit_check
    recommender_circuit(ENV['FAILURE_NUMBER'], ENV['WITHIN'])
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
