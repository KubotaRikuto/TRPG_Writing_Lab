class ChangeColumnWritingLike < ActiveRecord::Migration[6.1]
  def change
      add_foreign_key  :writing_likes, :members, column: :member_id
      add_foreign_key  :writing_likes, :writings, column: :writing_id
  end
end
