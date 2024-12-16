class CreateBlogComments < ActiveRecord::Migration[7.2]
  def change
    create_table :blog_comments do |t|
      t.text :review
      t.integer :user_id
      #t.integer :blog_id

      t.timestamps
    end
  end
end
