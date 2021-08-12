Rails.application.routes.draw do
  resources :transactions
  resources :income, controller: "transactions", type: "income" 
  resources :expense, controller: "transactions", type: "expense"
  resources :bank_transfer, controller: "transactions", type: "bank_transfer" 
  resources :wallets
  resources :bank_accounts
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    
  }
  
  devise_scope :user do
  
    authenticated do
      root 'dashboard#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
