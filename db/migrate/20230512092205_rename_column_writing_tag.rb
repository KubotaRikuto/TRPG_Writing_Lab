class RenameColumnWritingTag < ActiveRecord::Migration[6.1]
  def change
    rename_column :writing_tags, :writing_id_id, :writing
    rename_column :writing_tags, :tag_id_id, :tag
  end
end
