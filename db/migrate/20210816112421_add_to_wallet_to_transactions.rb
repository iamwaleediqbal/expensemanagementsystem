class AddToWalletToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :to_wallet, :boolean
  end
end
