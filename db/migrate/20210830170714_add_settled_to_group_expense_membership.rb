class AddSettledToGroupExpenseMembership < ActiveRecord::Migration[6.1]
  def change
    add_column :group_expense_memberships, :settled, :boolean
  end
end
