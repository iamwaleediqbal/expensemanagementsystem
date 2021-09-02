class BankAccountPolicy < ApplicationPolicy
    def index?
        user.present?
    end
     
    def create?
        user.present?
    end
    
    def show?
        return true if user.present? && user == bank_account.user
    end

    def update?
        return true if user.present? && user == bank_account.user
    end
     
    def destroy?
        return true if user.present? && user == bank_account.user
    end
     
    private
     
        def bank_account
          record
        end
end