Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/payments'

  root 'videos#index'

  get '/landing-page', to: 'landing#index', as: 'landing_page'
  get  '/home',   to: 'videos#index'
  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/categories/show'
  get 'mail_to_friend_was_sent', to: 'friend_invitations#mail_was_sent'

  namespace :admin do
      resources :videos, only: [:new, :create]
  end

  resources :charges, only: [:new, :create]
  resources :payments, only: [:index]

  resources :queue_items, only: [:index, :create, :destroy]
  post '/update_queue_items_update', to: 'queue_items#update_items'

  resources :friendships, only: [:index, :destroy] do
    member do
      post :create_friendship
    end
  end

  resources :users, only: [:show, :create]
  resources :reviews, only: :create
  resources :reset_passwords, only: [:new, :create, :edit, :update]
  resources :friend_invitations, only: [:new, :create]

  resources :videos, only: :show do
    collection do
      get :search
      post :search, to: "videos#search_form_submitted"
    end
  end

  resources :categories, only: :show









  # TODO remove this design files when you are done
  # TODO remove controllers/ui folder
  get 'ui', to: 'ui#index'
  namespace :ui do
    folder = "app/views/ui/"
    files  = Dir.entries(folder)
    filtered_files = files.map { |file| File.basename(file, '.html.haml') }.reject { |file| ['..', '.'].include? file }
    filtered_files.each do |file|
      get file
    end
  end
end

