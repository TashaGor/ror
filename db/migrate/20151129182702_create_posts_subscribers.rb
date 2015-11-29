class CreatePostsSubscribers < ActiveRecord::Migration
  def change
    create_table :posts_subscribers do |t|
      t.integer :post_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
