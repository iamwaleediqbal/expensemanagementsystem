class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :bank_account, null: true, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.float :amount
      t.string :type
      t.date :date_performed

      t.timestamps
    end
  end
end
