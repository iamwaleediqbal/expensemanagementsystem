class AddAmountBorrowedAndAmountLentToWallet < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :amount_borrowed, :float
    add_column :wallets, :amount_lent, :float
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
