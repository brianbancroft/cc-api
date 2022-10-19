Rails.application.routes.draw do
  apipie
  resources :widgets
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/', to: redirect('/apipie')
  
  namespace :api do
    namespace :v1 do
      resources :currencies, only: [:index] 
      get 'currencies/rate', to: 'currencies#rate'

        
          
        
      
    end
  end
end
