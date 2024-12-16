require 'time'

class ReblogsController < ApplicationController
  before_action :authenticate_admin!
  protect_from_forgery with: :exception
  before_action :set_blog, only: %i[ show edit update destroy ]

  # GET /blogs or /blogs.json
  def index
    @reblogs_index = Blog.includes(:body, :title).all
    query = params[:query]
    if query.present?
      @reblogs_index = @reblogs_index.full_text_search(query)
    end
    @reblogs = Kaminari.paginate_array(Blog.search(params[:query]).order(days: :desc)).page(params[:page])
    @version = 3
    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    @himekuri = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時"+"#{dt.min}分"+"#{dt.sec}秒" + ' : '.to_s + week + "曜日"
    sql = "SHOW pgroonga.libgroonga_version;"
    query = ActiveRecord::Base.connection.select_all(sql).to_a
    pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
    pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
    @pg_version = pg_string + " " + pg_number
  end

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @reblog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:days, :title, :status, :switch, :remove_status, :body, :file, :remove_file, :image, :remove_image, :video, :remove_video, images: [])
  end
end
