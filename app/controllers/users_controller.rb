class UsersController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :strong_auth_check, only: %i[ show ]

  def show
    @users = Kaminari.paginate_array(current_user.blogs.search(params[:query]).order("created_at DESC")).page(params[:page])
    @version = 3
    sql = "SHOW pgroonga.libgroonga_version;"
    query = ActiveRecord::Base.connection.select_all(sql).to_a
    pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
    pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
    @pg_version = pg_string + " " + pg_number
  end

  private
  def strong_auth_check
    @user = User.find_by(params[:id])
    if current_user.id != @user.id
      raise_not_found!
    end
  end
end
