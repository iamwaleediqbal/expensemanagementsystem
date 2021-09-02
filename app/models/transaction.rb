class Transaction < ApplicationRecord
  belongs_to :transfer_to, polymorphic: true, optional: true
  belongs_to :transfer_from, polymorphic: true
  belongs_to :user
  enum category: {food:1, transportation:2, accomodation:3, utility:4, other:5}

  scope :income, -> { where(type: 'Income') }
  scope :expense, -> { where(type: 'Expense') }  
  scope :bank_transfer, -> { where(type: 'BankTransfer') } 

  scope :filter_by_user, -> (user_id) {where user_id: user_id}
  scope :filter_by_bank_account, -> (bank_account_id) {where bank_account_id: bank_account_id}

  validates :amount, :type, presence: true
  validates :amount,:numericality => { :greater_than => 0}

  
end
