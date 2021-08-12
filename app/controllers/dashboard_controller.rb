class DashboardController < ApplicationController
        
    @dashboard = {}
    def index
        income = 0
        expense = 0
        balance = current_user.wallet.balance
        current_user.transactions.each do |transaction|
            if(transaction.is_a? Income)
            income += transaction.amount
            elsif(transaction.is_a? Expense)
            expense += transaction.amount
            end
        end
        p income
        @dashboard = {income: income, expense: expense, balance: balance}
    end
end