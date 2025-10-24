# frozen_string_literal: true

require 'grouse'
require 'time'

class BlogsController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :set_blog, only: %i[ show edit update destroy ]
  before_action :strong_auth_check, only: %i[ index ]

  # GET /blogs or /blogs.json
  def index
    @blogs_index = Blog.includes(:body, :title).all
    query = params[:query]
    if query.present?
      @blogs_index = @blogs_index.full_text_search(query)
    end
    @blogs = Kaminari.paginate_array(Blog.search(params[:query]).order(days: :desc)).page(params[:page])
    @version = version
    @himekuri = koyomi
    @pg_version = pg_version

    respond_to do |format|
      format.html
      format.csv { send_data Blog.generate_csv, filename: "blogs-#{Time.zone.now.strftime('%Y%m%d%s')}.csv" }
    end
  end

  def import
    Blog.import(params[:file])
    redirect_to blogs_url, notice: 'CSV imported.'
  end

  def set_csrf_token_header
    response.set_header('X-CSRF-Token', form_authenticity_token)
  end

  # GET /blogs/1 or /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs or /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to blog_url(@blog), notice: "Created a new blog post." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1 or /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to blog_url(@blog), notice: "The blog post has been updated!" }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1 or /blogs/1.json
  def destroy
    @blog.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "The blog post has been deleted." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def blog_params
    params.require(:blog).permit(:days, :title, :status, :switch, :remove_status, :body, :file, :remove_file, :image, :remove_image, :video, :remove_video, images: []).merge(user_id: current_user.id)
  end

  def strong_auth_check
    @user = User.find_by(params[:id])
    if current_user.id != @user.id
      raise_not_found!
    end
  end
end
