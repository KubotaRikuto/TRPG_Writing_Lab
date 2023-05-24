class AddColumnWriting < ActiveRecord::Migration[6.1]
  def change
    add_column :writings, :is_public, :boolean, default: true
  end
end
