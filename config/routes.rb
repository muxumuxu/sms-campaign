Rails.application.routes.draw do
  root to: 'campaigns#index'
  devise_for :users
  resources :campaigns do
    member do
      get :name
      get :message
      get :preview
      get :schedule_time
      post :schedule
      post :send_now
    end
  end
  resources :mailing_lists do
    member do
      get :upload_csv
      post :import_csv
      get :import_csv_results
    end
  end
  resources :contacts
end
