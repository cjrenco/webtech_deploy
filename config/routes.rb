Rails.application.routes.draw do
  devise_for :utilizers, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  
  
  get "up" => "rails/health#show"
  get "service-worker" => "rails/pwa#service_worker"
  get "manifest" => "rails/pwa#manifest"

 
  root to: "pages#home"
  get '/about', to: 'pages#about'
  get '/contact', to: 'pages#contact'
  

  resources :courses do
    resources :lessons do
      
      resources :lesson_completions, only: [:create, :destroy]

      resources :forums do
        resources :questions do
          resources :answers
        end
      end
    end
  end
end
