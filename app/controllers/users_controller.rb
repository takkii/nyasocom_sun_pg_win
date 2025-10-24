# frozen_string_literal: true

require 'nym'

class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :strong_auth_check, only: %i[ show ]

  def show
    @users = Kaminari.paginate_array(current_user.blogs.search(params[:query]).order("created_at DESC")).page(params[:page])
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
