json.extract! bank_account, :id, :name, :account_number, :balance, :user_id, :created_at, :updated_at
json.url bank_account_url(bank_account, format: :json)
