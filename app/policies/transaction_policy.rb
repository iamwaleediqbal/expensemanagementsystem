class TransactionPolicy < ApplicationPolicy
    def index?
        true
    end
     
    def create?
        user.present?
    end
    
    def show?
        user.present?
    end
    
    def update?
        return true if user.present? && user == transaction.user
    end
     
    def destroy?
        return true if user.present? && user == transaction.user
    end
     
    private
     
        def transaction
          record
        end
end