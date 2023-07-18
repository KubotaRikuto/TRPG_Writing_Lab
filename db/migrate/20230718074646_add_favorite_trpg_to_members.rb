class AddFavoriteTrpgToMembers < ActiveRecord::Migration[6.1]
  def change
    add_column :members, :favorite_trpg, :string
  end
end
