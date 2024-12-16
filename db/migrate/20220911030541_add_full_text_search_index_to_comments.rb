class AddFullTextSearchIndexToComments < ActiveRecord::Migration[7.0]
  def change
    add_index(:comments, :body, using: "pgroonga")
  end
end
