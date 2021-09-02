json.extract! transaction, :id, :transfer_from_id, :transfer_to_id, :transfer_to_type, :transfer_to_type, :user_id, :amount, :type, :category, :from_wallet, :date_performed, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
