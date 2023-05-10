class RenameTableToPostLikesAndPostComments < ActiveRecord::Migration[6.1]
  def change
    rename_table :post_likes, :writing_likes
    rename_table :post_comments, :writing_comments
  end
end
