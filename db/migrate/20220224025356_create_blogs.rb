class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.date :days
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
