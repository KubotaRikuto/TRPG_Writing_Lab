class RemoveColumnWritingLikes < ActiveRecord::Migration[6.1]
  def change
    remove_column :writing_likes, :like_count, :integer
  end
end
