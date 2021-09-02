class TransactionPolicy < ApplicationPolicy
    def index?
        user.present?
    end
     
    def create?
        user.present?
    end
    
    def show?
        return true if user.present? && user == transaction.user
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