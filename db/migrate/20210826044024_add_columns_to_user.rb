class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :amount_lent, :float
    add_column :users, :amount_borrowed, :float
  end
end
