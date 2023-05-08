class DropTagsTable < ActiveRecord::Migration[6.1]
  def change
    drop_table :tags
    drop_table :writing_tags
  end
end
