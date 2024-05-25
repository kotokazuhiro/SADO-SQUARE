class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer    :user_id
      t.integer    :genre_id
      t.string     :title,        null: false
      t.string     :place,        null: false
      t.string     :content,      null: false
      t.boolean    :delete_flag
      t.timestamps
    end
  end
end
