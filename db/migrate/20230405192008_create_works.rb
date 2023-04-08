class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      # 外部キー
      t.integer :trpg_rule_id, null: false  # 既存のTRPGルール項目
      t.integer :post_searchability_id, null: false  # タグ検索ID(中間テーブル)

      t.string :title, null: false  # 作品タイトル
      t.text :summary  # 作品概要
      t.boolean :work_type, default: true, null: false  # 作品の種類(シナリオ or ルール)
      t.integer :number_of_players, null: false  # プレイ人数
      t.integer :play_time, null: false  # プレイ時間
      t.integer :difficulty, null: false  # 難易度

      t.timestamps
    end
  end
end
