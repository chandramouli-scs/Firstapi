Rails.application.routes.draw do

  # Jwt_auth routes
      resources :unlocks, controller: 'rails_jwt_auth/unlocks', only: %i[update]
      resources :invitations, controller: 'rails_jwt_auth/invitations', only: [:create, :update]
      resources :passwords, controller: 'rails_jwt_auth/passwords', only: [:create, :update]
      resources :confirmations, controller: 'rails_jwt_auth/confirmations', only: [:create, :update]
      resource :registration, controller: 'rails_jwt_auth/registrations', only: [:create]
      resource :session, controller: 'rails_jwt_auth/sessions', only: [:create, :destroy]
      
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
  	namespace 'v1' do
  
      # Article routes
      resources :articles
  	end 
  end
end
