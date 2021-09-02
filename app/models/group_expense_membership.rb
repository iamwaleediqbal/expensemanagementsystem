class GroupExpenseMembership < ApplicationRecord
  belongs_to :group_expense
  belongs_to :borrower, :class_name => "User", :foreign_key => :borrower_id
  belongs_to :lenter, :class_name => "User", :foreign_key => :lenter_id
end
