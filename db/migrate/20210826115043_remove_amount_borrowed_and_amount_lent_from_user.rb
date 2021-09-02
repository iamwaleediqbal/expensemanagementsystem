class RemoveAmountBorrowedAndAmountLentFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :amount_borrowed
    remove_column :users, :amount_lent
  end
end
