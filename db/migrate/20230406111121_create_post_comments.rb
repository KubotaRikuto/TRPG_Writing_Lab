class CreatePostComments < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comments do |t|

      # 外部キー
      t.integer :member_id, null: false
      t.integer :work_id, null: false

      t.string :comment, null: false

      t.timestamps
    end
  end
end
