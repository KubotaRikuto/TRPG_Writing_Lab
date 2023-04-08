class CreatePostLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :post_likes do |t|

      # 外部キー
      t.integer :member_id, null: false
      t.integer :work_id, null: false

      t.integer :like_count, null: false, default: 0

      t.timestamps
    end
  end
end
