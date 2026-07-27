class CreateTweets < ActiveRecord::Migration[8.1]
  def change
    create_table :tweets do |t|
      t.text :body, null: false
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
