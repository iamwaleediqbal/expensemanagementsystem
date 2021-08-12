class User < ApplicationRecord
  has_many :bank_accounts
  has_many :transactions
  has_one :wallet

  validates :name,:email,:password, presence: true
  validates :email, uniqueness: true
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
