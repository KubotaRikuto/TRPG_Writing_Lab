class CreateWritingTags < ActiveRecord::Migration[6.1]
  def change
    create_table :writing_tags do |t|

      t.timestamps
    end
  end
end
