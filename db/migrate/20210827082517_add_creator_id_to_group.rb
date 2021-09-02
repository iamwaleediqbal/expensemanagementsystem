class AddCreatorIdToGroup < ActiveRecord::Migration[6.1]
  def change
    add_reference :groups, :creator, foreign_key: { to_table: :users }
  end
end
