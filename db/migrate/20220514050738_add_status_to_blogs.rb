class AddStatusToBlogs < ActiveRecord::Migration[7.0]
  def change
    add_column :blogs, :status, :boolean, default: false, null: false
  end
end
