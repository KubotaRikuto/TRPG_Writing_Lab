class CreateTrpgRules < ActiveRecord::Migration[6.1]
  def change
    create_table :trpg_rules do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
