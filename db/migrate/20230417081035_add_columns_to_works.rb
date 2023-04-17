class AddColumnsToWorks < ActiveRecord::Migration[6.1]
  def change
    add_column :works, :max_play_time, :integer, null: false
    add_column :works, :min_play_time, :integer, null: false
    add_column :works, :max_players, :integer, null: false
    add_column :works, :min_players, :integer, null: false
    remove_column :works, :number_of_players
    remove_column :works, :play_time
  end
end
