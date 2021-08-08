Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#top'
  resources :user_books
  post '/user_books/:id' => "user_books#update"
  
  get 'search' => 'user_books#search'
end
