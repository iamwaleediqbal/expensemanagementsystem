class CreateGroupExpenseMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :group_expense_memberships do |t|
      t.references  :group_expense, foreign_key: {to_table: :group_expenses}
      t.references :borrower, foreign_key: { to_table: :users }
      t.references :lenter, foreign_key: { to_table: :users }
      t.float :amount

      t.timestamps
    end
  end
end
