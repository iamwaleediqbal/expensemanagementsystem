class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :transfer_to, polymorphic: true
      t.references :transfer_from, polymorphic: true
      t.float :amount
      t.string :type
      t.date :date_performed
      t.integer  :category
      t.timestamps
    end
  end
end
