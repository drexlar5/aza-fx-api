Rails.application.routes.draw do
  
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  scope :api do
    scope :v1 do
      post 'authenticate', to: 'authentication#authenticate'
      post 'register', to: 'authentication#register'

      scope module: 'transactions' do
        resources :transactions, controller: :transaction, only: [:index, :show, :create]
      end
    end
  end
end
