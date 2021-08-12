json.extract! transaction, :id, :bank_account_id, :user_id, :amount, :type, :category, :from_wallet, :date_performed, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
