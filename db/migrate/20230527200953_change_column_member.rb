class ChangeColumnMember < ActiveRecord::Migration[6.1]
  def change
    change_column :members, :introduction, :string, default: "よろしくお願いします！"
  end
end
