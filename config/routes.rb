Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :user_books
  post '/user_books/:id' => "user_books#update"
  
  get '/categories/index' => 'categories#index'
  get '/categories/:id/edit' => 'categories#edit', as: 'category_edit'
  post '/categories/create' => 'categories#create'
  post '/categories/update' => 'categories#update'
  delete '/categories/:id' => 'categories#destroy', as: 'category_destroy'
  
  get '/feeling_categories/index' => 'feeling_categories#index'
  get '/feeling_categories/:id/edit' => 'feeling_categories#edit', as: 'feeling_category_edit'
  post '/feeling_categories/create' => 'feeling_categories#create'
  post '/feeling_categories/update' => 'feeling_categories#update'
  delete '/feeling_categories/:id' => 'feeling_categories#destroy', as: 'feeling_categories_destroy'
  
  get 'search' => 'user_books#search'
end
