class GroupExpense < ApplicationRecord
  belongs_to :group
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
  has_many :group_expense_memberships
end
