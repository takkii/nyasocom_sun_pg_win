class AddBackgroundToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :switch, :boolean, default: false, null: false
  end
end
