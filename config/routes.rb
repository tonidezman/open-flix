Rails.application.routes.draw do


  get 'home', to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'
end
