class AddPercentToGroupExpense < ActiveRecord::Migration[6.1]
  def change
    add_column :group_expenses, :percent, :boolean
  end
end
