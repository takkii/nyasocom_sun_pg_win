# frozen_string_literal: true

require 'grouse'
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
    @version = version
    @himekuri = koyomi
    @pg_version = pg_version
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
