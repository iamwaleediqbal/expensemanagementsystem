class User < ApplicationRecord
  has_many :bank_accounts, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_one :wallet, dependent: :destroy
  has_many :groups, :through => :memberships
  has_many :memberships
  validates :email,:password, presence: true
  validates :email, uniqueness: true
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.find_by_invitation_token(*)
    super.tap do |record|
      # logger.debug record.inspect
      # logger.debug record.errors.to_a.inspect
    end
  end
  def incomes
    self.transactions.where(type: Income.name)
  end

  def expenses
    self.transactions.where(type: Expense.name)
  end
end
