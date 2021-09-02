class WalletPolicy < ApplicationPolicy
    def index?
        user.present?
    end
     
    def create?
        user.present?
    end
    
    def show?
        return true if user.present? && user == wallet.user
    end

    def update?
        return true if user.present? && user == wallet.user
    end
     
    def destroy?
        return true if user.present? && user == wallet.user
    end
     
    private
     
        def wallet
          record
        end
end