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
  
  get '/feeling_categories/edit' => 'feeling_categories#edit'
  
  get 'search' => 'user_books#search'
end
