class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.number :user_id, foreign_key: {to_table: :users}
      t.number :post_id, foreign_key: {to_table: :posts}
      t.date :created_at
      t.date :updated_at
      t.timestamps
    end
  end
end
