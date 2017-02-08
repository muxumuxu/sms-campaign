Rails.application.routes.draw do
  get 'contacts/new'

  get 'contacts/create'

  get 'contacts/edit'

  get 'contacts/update'

  get 'contacts/destroy'

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
  resources :mailing_lists
end
