Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'links#index' , as:'home'
  resources :links
  get '/search',to: 'links#search'
end
