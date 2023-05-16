class RemoveColumnWriting < ActiveRecord::Migration[6.1]
  def change
    remove_column :writings, :writing_tag_id, :integer
  end
end
