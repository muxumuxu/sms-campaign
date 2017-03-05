Rails.application.routes.draw do
  root to: 'campaigns#index'
  devise_for :users
  resources :campaigns do
    member do
      get :name, to: "campaigns#name"
      get :message, to: "campaigns#message"
      get :preview, to: "campaigns#preview"
      get :schedule, to: "campaigns#schedule"
    end
  end
  resources :mailing_lists do
    member do
      get :upload_csv
      get :import_csv
      get :import_csv_results

      post :import_csv
    end
  end
  resources :contacts
end
