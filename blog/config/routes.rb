Rails.application.routes.draw do
  get 'articles/index'

  get 'welcome/index'
  root 'welcome#index'

  resources :articles
  #begin
  #  get "/articles"
  #  post "/articles"
  #  delete "/articles"
  #  get "/articles/:id"
  #  get "/articles/new"
  #  get "/articles/:id/edit"
  #  patch "/articles/:id"
  #  put "/articles/:id"
  #end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
