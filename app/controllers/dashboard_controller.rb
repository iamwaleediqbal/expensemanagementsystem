class DashboardController < ApplicationController
  @dashboard = {}
  def index
    income = current_user.incomes.sum(:amount)
    expense = current_user.expenses.sum(:amount)
    if(!current_user.wallet)
      current_user.wallet = Wallet.new
      current_user.wallet.balance = 0
      current_user.wallet.save
    end
    if(current_user.wallet.balance < 0)
      current_user.wallet.balance = 0
      current_user.wallet.save
    end
    
    balance = current_user.wallet.balance
    lent = current_user.wallet.amount_lent
    borrow = current_user.wallet.amount_borrowed
    @dashboard = {income: income, expense: expense, balance: balance, lent: lent, borrow: borrow}
  end
end