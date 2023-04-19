class DropOldTableToWorks < ActiveRecord::Migration[6.1]
  def change
    drop_table :works
  end
end
