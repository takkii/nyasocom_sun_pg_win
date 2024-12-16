class AddUserIdToBlogs < ActiveRecord::Migration[7.1]
  def change
    add_column :blogs, :user_id, :integer, null: false, default: 0
  end
end
