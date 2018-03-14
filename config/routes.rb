Rails.application.routes.draw do

  root 'videos#index'

  get '/landing-page', to: 'landing#index', as: 'landing_page'
  get  '/home',   to: 'videos#index'
  get  '/login',  to: 'sessions#new'
  post '/login',  to: 'sessions#create'
  get '/logout',  to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/categories/show'

  # get 'queue_items/index', as: 'queue_items'
  resources :queue_items, only: [:index, :create, :destroy]

  resources :users, only: :create
  resources :reviews, only: :create

  resources :videos, only: :show do
    collection do
      post :search
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

