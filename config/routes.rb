Rails.application.routes.draw do
  root 'videos#index'

  get 'categories/show'
  get 'home', to: 'videos#index'

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

