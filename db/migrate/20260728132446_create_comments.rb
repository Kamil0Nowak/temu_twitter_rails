class CreateComments < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.integer :likes_count, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
      add_index :comments, [:tweet_id, :created_at]
  end
end
