class BankAccount < ApplicationRecord
    belongs_to :user
    validates :name,  :account_number, presence: true
    validates :account_number, uniqueness: true
    validates :balance,:numericality => { :greater_than => -1}
    scope :filter_by_user, -> (user_id) {where user_id: user_id}
end
