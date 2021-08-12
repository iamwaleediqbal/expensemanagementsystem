class AddUser < ActiveRecord::Migration[6.1]
  def change
    add_column :bank_accounts, :user_id, :bigint
    add_foreign_key :bank_accounts, :users
  end
end
