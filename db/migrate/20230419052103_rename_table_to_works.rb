class RenameTableToWorks < ActiveRecord::Migration[6.1]
  def change
    rename_table :new_works, :works
    add_column :works, :created_at, :datetime, precision: 6, null: false
    add_column :works, :updated_at, :datetime, precision: 6, null: false
  end
end
