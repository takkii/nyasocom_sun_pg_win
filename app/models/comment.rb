class Comment < ApplicationRecord
  # seach method
  def self.search(search)
    return Comment.preload(@comments).all unless search
    comments = Comment.arel_table
    Comment.where(comments[:body].matches("%#{search}%"))
  end

  # Use PGroonga.
  scope :full_text_search, -> (query) {
    where("body @@ ?", query)
  }
end
