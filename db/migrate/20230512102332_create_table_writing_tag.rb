class CreateTableWritingTag < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_tags do |t|
      t.references :writing, foreign_key: true
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
