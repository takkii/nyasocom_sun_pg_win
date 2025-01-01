class BlogCommentsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    @review = BlogComment.create!(blog_comment_params)
    @review.save
  end


  def destroy
    # Delete one week
    @review = BlogComment.where("created_at > ?", Time.now - 7.days).destroy_all
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:review, :user_id, :blog_id).merge(user_id: current_user.id)
  end
end
