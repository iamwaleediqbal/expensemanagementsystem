Rails.application.routes.draw do
  resources :group_expense_memberships
  #resources :group_expenses
  resources :memberships
  resources :groups
  resources :transactions
  resources :income, controller: "transactions", type: "income" 
  resources :expense, controller: "transactions", type: "expense"
  resources :bank_transfer, controller: "transactions", type: "bank_transfer" 
  resources :wallets do
    resources :transactions, module: :wallets
  end
  resources :bank_accounts do
    resources :transactions, module: :bank_accounts
  end
  resources :groups do 
    resources :group_expenses
    
  end  
  devise_scope :user do
  
    authenticated do
      root 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',   
    invitations: 'users/invitations', 
  }
end


