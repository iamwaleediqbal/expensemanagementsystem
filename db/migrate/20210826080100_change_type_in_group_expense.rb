class ChangeTypeInGroupExpense < ActiveRecord::Migration[6.1]
  def change
    rename_column :group_expenses, :type, :equal
  end
end
