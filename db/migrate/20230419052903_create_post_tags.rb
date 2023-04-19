class CreatePostTags < ActiveRecord::Migration[6.1]
  def change
    create_table :post_tags do |t|
      t.integer :work_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
    add_index :post_tags, [:work_id, :tag_id], length: 10, unique: true
  end
end
