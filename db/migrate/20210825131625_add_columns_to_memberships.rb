class AddColumnsToMemberships < ActiveRecord::Migration[6.1]
  def change
    add_column :memberships, :amount, :float
    add_column :memberships, :active, :boolean
  end
end
