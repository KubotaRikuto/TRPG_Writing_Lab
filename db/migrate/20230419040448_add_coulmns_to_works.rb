class AddCoulmnsToWorks < ActiveRecord::Migration[6.1]
  def change
    remove_column :works, :member_id
    remove_column :works, :trpg_rule_id
    remove_column :works, :post_searchability_id

    remove_column :works, :difficulty


    add_column :works, :member_id, :integer, null: false, before: :trpg_rule_id
    add_column :works, :trpg_rule_id, :integer, null: false
    add_column :works, :post_tag_id, :integer, null: false, after: :trpg_rule_id

    add_column :works, :title, :string, null: false
    add_column :works, :summary, :text
    add_column :works, :work_type, :boolean, default: true, null: false
    add_column :works, :max_play_time, :integer, null: false
    add_column :works, :min_play_time, :integer, null: false
    add_column :works, :max_players, :integer, null: false
    add_column :works, :min_players, :integer, null: false
    add_column :works, :difficulty, :integer, null: false, after: :min_players
  end
end
