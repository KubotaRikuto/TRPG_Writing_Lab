class RenameColumnTag < ActiveRecord::Migration[6.1]
  def change
    rename_column :tags, :name, :tag_name
  end
end
