class AddFullTextSearchIndexToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_index(:blogs, :body, using: "pgroonga")
  end
end
