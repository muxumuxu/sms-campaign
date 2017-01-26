Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :campaigns
  resources :mailing_lists
end
