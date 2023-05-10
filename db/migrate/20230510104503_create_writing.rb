class CreateWriting < ActiveRecord::Migration[6.1]
  def change
    create_table :writings do |t|
      t.integer :member_id, null: false
      t.integer :trpg_rule_id, null: false
      t.integer :writing_tag_id, null: false

      t.string :title, null: false
      t.text :summary
      t.boolean :writing_type, default: true, null: false

      t.integer :max_play_time, null: false
      t.integer :min_play_time, null: false
      t.integer :max_players, null: false
      t.integer :min_players, null: false
      t.integer :difficulty, null: false

      t.timestamps
    end
  end
end
