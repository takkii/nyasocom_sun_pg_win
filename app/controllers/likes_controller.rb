class LikesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token
  before_action :blog_params

  def create
    Like.create(user_id: current_user.id, blog_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, blog_id: params[:id]).destroy
  end

  private

  def blog_params
    @blog = Blog.find(params[:id])
  end
end
