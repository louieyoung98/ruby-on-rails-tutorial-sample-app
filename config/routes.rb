Rails.application.routes.draw do
  root 'static_pages#home'

  get '/home',    to: 'static_pages#home'
  get '/about',   to: 'static_pages#about'
  get '/help',    to: 'static_pages#help'
  get '/contact', to: 'static_pages#contact'

  get '/new',     to: 'users#new', as: 'signup'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
