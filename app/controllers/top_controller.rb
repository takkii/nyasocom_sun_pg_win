# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'core'
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
    @version = CoreNYM.version
    @himekuri = CoreNYM.koyomi
    @pg_version = CoreNYM.pg_version
  end
end
