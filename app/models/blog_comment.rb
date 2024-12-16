class BlogComment < ApplicationRecord
    belongs_to :blog_comment, optional: true, dependent: :destroy
    validates :review, presence: true
    validates :review, blog_comments: true

  # seach method
  def self.search(search)
    return BlogComment.preload(@review).all unless search
    blog_comment = BlogComment.arel_table
    BlogComment.where(blog_comment[:review].matches("%#{search}%"))
  end
end
