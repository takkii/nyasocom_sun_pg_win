# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'version'

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
    sql = "SHOW pgroonga.libgroonga_version;"
    query = ActiveRecord::Base.connection.select_all(sql).to_a
    pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
    pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
    @pg_version = pg_string + " " + pg_number
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
