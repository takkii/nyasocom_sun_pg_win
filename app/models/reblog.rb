class Reblog < ApplicationRecord
  belongs_to :user, optional: true
  has_many :likes

  has_one_attached :image
  has_one_attached :video
  has_many_attached :images

  # picture image uploader
  mount_uploader :image, ImageUploader

  # movie video uploder
  mount_uploader :video, VideoUploader

  # seach method
  def self.search(search)
    return Blog.preload(@reblogs).all unless search
    blogs = Blog.arel_table
    # title or body in blogs
    # Blog.where(blogs[:title].matches("%#{search}%").or(blogs[:body].matches("%#{search}%")))

    # body only in blogs
    Blog.where(blogs[:body].matches("%#{search}%"))
  end

  scope :full_text_search, -> (query) {
    where("body @@ ?", query)
  }
end
