class GroupPolicy < ApplicationPolicy
    def index?
        user.present?
    end
     
    def create?
        user.present?
    end
    
    def show?
        return true if user.present? && user == group.creator
    end

    def update?
        return true if user.present? && user == group.creator
    end
     
    def destroy?
        return true if user.present? && user == group.creator
    end
     
    private
     
        def group
          record
        end
end