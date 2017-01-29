Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :campaigns
  get    "campaigns/new/message", to: "campaigns#message"
  get    "campaigns/new/preview", to: "campaigns#preview"
  get    "campaigns/new/schedule",to: "campaigns#schedule"
  resources :mailing_lists
end
