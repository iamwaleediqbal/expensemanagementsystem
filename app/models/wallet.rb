class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions, as: :transfer_to
  has_many :transactions, as: :transfer_from
end
