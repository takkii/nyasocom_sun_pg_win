# frozen_string_literal: true

require 'time'

class TopController < ActionController::Base
  def index
    @comment_id = BlogComment.where("user_id > ?", params[:id])
    @blog_comment = BlogComment.new
    @bl_com = Kaminari.paginate_array(BlogComment.search(params[:search]).order(created_at: :desc)).page(params[:page])
    @blogs = Kaminari.paginate_array(Blog.search(params[:search]).order(days: :desc)).page(params[:page])
    @status = Kaminari.paginate_array(Blog.where(status: 'false').order(days: :desc)).page(params[:page])
    # comment paginate 5 page
    @comments = Kaminari.paginate_array(Comment.search(params[:search]).order(created_at: :desc)).page(params[:page]).per(5)
    @version = 3
    sql = "SHOW pgroonga.libgroonga_version;"
    query = ActiveRecord::Base.connection.select_all(sql).to_a
    pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
    pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
    @pg_version = pg_string + " " + pg_number

    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    @himekuri = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時"+"#{dt.min}分"+"#{dt.sec}秒" + ' : '.to_s + week + "曜日"
  end
end
