Rails.application.routes.draw do
  root "static_pages#home"

  resources :users

  get "/home",    to: "static_pages#home"
  get "/about",   to: "static_pages#about"
  get "/help",    to: "static_pages#help"
  get "/contact", to: "static_pages#contact"

  get "/signup",  to: "users#new", as: "signup"

  get "/login",    to: "sessions#new"
  post "/login",   to: "sessions#create"
  delete "/login", to: "sessions#destroy"
end
