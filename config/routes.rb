Specmon::Engine.routes.draw do
  root to: 'builds#last'

  resources :projects, only: :show do
    resources :builds do
      get :last, on: :collection
      resources :examples, only: [:show, :chart] do
        get :chart
      end
    end
  end
end
