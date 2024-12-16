class AddVideoToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :video, :string
  end
end
