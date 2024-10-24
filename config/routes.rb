Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboard', to: 'pages#dashboard'
  get 'dashboard2', to: 'pages#dashboard2'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  get 'clock_in', to: 'clock_ins#new', as: 'clock_in_page'
  # root "posts#index"

  resources :sites
  resources :clock_ins, only: [:create]

  resources :schedules do
    collection do
      post :update_event
    end
    resources :shifts
  end

  resources :shifts do
    member do
      post 'clock_in'
    end
  end

  resources :requests do
    member do
      patch 'approve'
      patch 'reject'
    end
  end
end
