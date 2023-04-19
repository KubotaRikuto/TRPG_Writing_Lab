class RenameColumnToTables < ActiveRecord::Migration[6.1]
  def change
    rename_column :writings, :post_tag_id, :writing_tag_id
    rename_column :writings, :work_type, :writing_type
    rename_column :writing_comments, :work_id, :writing_id
    rename_column :writing_tags, :work_id, :writing_id
  end
end
