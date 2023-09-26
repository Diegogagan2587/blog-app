class CreateUser < ActiveRecord::Migration[7.0]
  has_many :posts
  
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.date :updated_at
      t.date :created_at
      t.number :posts_counter
      t.timestamps
    end
  end
end
