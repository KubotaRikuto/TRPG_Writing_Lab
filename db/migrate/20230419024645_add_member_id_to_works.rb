class AddMemberIdToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :member_id, :integer, null: false
  end
end
