class AddFullTextSearchIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index(:users, :email, using: "pgroonga")
  end
end
