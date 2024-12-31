require 'open3'

class ApplicationController < ActionController::Base
  before_action :set_locale
  before_filter :validate_ipadress

  def after_sign_in_path_for(resource)
    #root_path # ログイン後に遷移するpathを設定
    new_two_step_verification_path
  end

  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def raise_not_found!
    e = ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
    render_404(e)
  end

  private

  def validate_ipadress
    # allowed_sources
    local_ip = AllowedSource.all
    nodejs_path = "node" + " " + "#{File.dirname(__FILE__) + '/myipad.js'}"
    stdout_js, stderr_js, status_js = Open3.capture3(nodejs_path)
      if "#{stdout_js}" == "#{local_ip.octet1} + #{local_ip.octet2} + #{local_ip.octet3} + #{local_ip.octet4}"
     else
       blog_comments.errors.add('The conditional expression returned false.')
     end
  end

  def render_404(e)
    logger.warn e
    render file: "public/404.html", status: :not_found, layout: false
  end
end
