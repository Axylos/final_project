GlossolHellYeah::Application.routes.draw do

  shallow do
    resources :users, only: [:create, :new, :update, :destroy] do
      resources :documents
    end
  end
  resource :session, only: [:create, :new, :destroy]
  resources :documents do
    resources :annotations, only: [:create]
  end

  root to: "users#new"


end