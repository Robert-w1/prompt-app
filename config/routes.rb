Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "chats#index", as: :authenticated_root
  end

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  # root "posts#index"
  resources :chats, only: [:index, :show, :create] do
    resources :messages, only: [:create]
  end
  
  resources :projects, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  # Search route for all (prompts, messages, chats, projects)
  get 'search', to: 'search#index', as: 'search'

end
