class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.numeric :user_id, foreign_key: {to_table: :users}
      t.numeric :post_id, foreign_key: {to_table: :posts}
      t.timestamps
    end
  end
end
