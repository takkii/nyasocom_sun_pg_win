class AddIndexBlogsTitle < ActiveRecord::Migration[7.0]
  def change
    add_index :blogs, :title, unique: true
  end
end
