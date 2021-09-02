class AddCreatorIdToGroupExpense < ActiveRecord::Migration[6.1]
  def change
    add_reference :group_expenses, :creator, foreign_key: { to_table: :users }
  end
end
