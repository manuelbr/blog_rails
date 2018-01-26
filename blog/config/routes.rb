Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  resources :articles
=begin
  get "/articles" index
  post "/articles" create
  delete "/articles/:id" destroy
  get "/articles/:id" show
  get "/articles/new" new
  get "/articles/:id/edit" edit
  put "/articles/:id" update
=end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
