class AddImageToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :image, :string
  end
end
