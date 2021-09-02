class Group < ApplicationRecord
    has_many :memberships
    has_many :users, :through => :memberships
    has_many :group_expenses
    belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
    accepts_nested_attributes_for :group_expenses

end
