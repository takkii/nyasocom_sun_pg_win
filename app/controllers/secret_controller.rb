# frozen_string_literal: true

require 'core'
require 'date'
require 'time'

class SecretController < BlogsController
  before_action :authenticate_user!
  before_action :strong_auth_check, only: %i[ index ]

  def index
    @status = Kaminari.paginate_array(Blog.where(status: 'true').order(days: :desc)).page(params[:page]).per(5)
    @version = CoreNYM.version
    @himekuri = CoreNYM.koyomi
    @pg_version = CoreNYM.pg_version
  end

private
  def strong_auth_check
    @user = User.find_by(params[:id])
    if current_user.id != @user.id
      raise_not_found!
    end
  end
end
