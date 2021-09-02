json.extract! group_expense_membership, :id, :group_expense_id, :borrower_id, :lenter_id, :amount, :created_at, :updated_at
json.url group_expense_membership_url(group_expense_membership, format: :json)
