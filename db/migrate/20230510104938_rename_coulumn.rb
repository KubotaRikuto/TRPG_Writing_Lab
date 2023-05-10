class RenameCoulumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :writing_comments, :work_id, :writing_id
    rename_column :writing_likes, :work_id, :writing_id
  end
end
