class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :post_id
      t.boolean :delete_flag

      t.timestamps
    end
  end
end