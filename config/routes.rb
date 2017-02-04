Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users
  resources :campaigns do
    member do
      get :campaign_name, to: "campaigns#campaign_name"
      get :message, to: "campaigns#message"
      get :preview, to: "campaigns#preview"
      get :schedule, to: "campaigns#schedule"
    end
  end
  resources :mailing_lists
end
