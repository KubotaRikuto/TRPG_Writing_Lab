class CreateWritingTagsAndTags < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_tags do |t|
      t.references :writing_id, null: false
      t.references :tag_id, null: false 
      
      t.timestamps
    end
    create_table :tags do |t|
      t.string :name, null: false
      t.boolean :admin_created, null: false, default: false
      
      t.timestamps
    end
    add_index :writing_tags, [:writing_id, :tag_id], unique: true

  end
end
