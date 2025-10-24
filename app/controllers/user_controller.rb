# frozen_string_literal: true

require 'nym'

class UserController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user, :only => [:index, :destroy]

  def index
    @users_index = User.includes(:email).all
    query = params[:query]
    if query.present?
      @users_index = @users_index.full_text_search(query)
    end
    @users = Kaminari.paginate_array(User.search(params[:query]).order(created_at: :desc)).page(params[:page])
    @version = CoreNYM.version
    @himekuri = CoreNYM.koyomi
    @pg_version = CoreNYM.pg_version
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'The user has been deleted.'
    redirect_to user_index_path
  end

  private
  def set_user
    @user = User.find_by(:id => params[:id])
  end
end
