class RenameTableToWriting < ActiveRecord::Migration[6.1]
  def change
    rename_table :works, :writings
    rename_table :post_likes, :writing_likes
    rename_table :post_comments, :writing_comments
    rename_table :post_tags, :writing_tags
  end
end
