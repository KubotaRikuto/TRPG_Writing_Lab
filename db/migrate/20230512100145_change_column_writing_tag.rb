class ChangeColumnWritingTag < ActiveRecord::Migration[6.1]
  def change
    add_reference :writing_tags, :writing, foreign_key: true
    add_reference :writing_tags, :tag, foreign_key: true
    remove_columns :writing_tags, :writing, :tag
  end
end
