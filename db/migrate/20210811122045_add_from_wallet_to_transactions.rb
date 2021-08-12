class AddFromWalletToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :from_wallet, :boolean
  end
end
