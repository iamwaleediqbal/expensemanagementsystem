class GroupExpensePolicy < ApplicationPolicy
    def index?
        user.present?
    end
     
    def create?
        user.present?
    end
    
    def show?
        return true if user.present? && user == group_expense.creator
    end

    def update?
        return true if user.present? && user == group_expense.creator
    end
     
    def destroy?
        return true if user.present? && user == group_expense.creator
    end
     
    private
     
        def group_expense
          record
        end
end