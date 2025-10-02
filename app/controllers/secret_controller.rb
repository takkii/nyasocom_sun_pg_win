require 'date'
require 'time'

class SecretController < BlogsController
  before_action :authenticate_user!
  before_action :strong_auth_check, only: %i[ index ]

  def index
    @status = Kaminari.paginate_array(Blog.where(status: 'true').order(days: :desc)).page(params[:page]).per(5)
    dt = Date.today
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    td = Time.new
    @himekuri = "#{td.year}年" + "#{td.month}月" + "#{td.day}日" + ' : '.to_s + "#{td.hour}時"+"#{td.min}分"+"#{td.sec}秒" + ' : '.to_s + week + "曜日"
    @version = 3.2
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
