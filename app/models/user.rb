class User < ApplicationRecord
  has_many :blogs
  has_many :likes

  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, #:registerable, :recoverable, :confirmable,
    :rememberable, :validatable

  validates :email, on: :create, presence: true, uniqueness: true
  validates :password, on: :create, presence: true

  # seach method
  def self.search(search)
    return User.preload(@users).all unless search

    users = User.arel_table
    User.where(users[:email].matches("%#{search}%"))
  end

  def liked_by?(blog_id)
    likes.where(blog_id: blog_id).exists?
  end

  scope :full_text_search, -> (query) {
    where("email @@ ?", query)
  }
end
