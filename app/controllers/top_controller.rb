# frozen_string_literal: true

require 'grouse'
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
    @version = version
    @himekuri = koyomi
    @pg_version = pg_version
  end
end
