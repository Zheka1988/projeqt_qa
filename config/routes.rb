Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"
  resources :questions, shallow: true do
    # member { delete 'links/:id', to: 'links#destroy', as: 'links_destroy' }
    member { post :like }
    member { post :dislike }
    resources :answers, only: [:create, :update, :destroy] do
      member { post :best_answer }
      member { post :like }
      member { post :dislike }
    end
  end
  resources :rewards, only: [:index]
  resources :links, only: [:destroy]
  resources :attach_files, only: [:destroy]
  # get 'rewards', to: 'rewards#index', as: 'rewards'
  # delete '/links/:id', to: 'links#destroy', as: 'links_destroy'
  # delete '/attach_files/:id', to: 'attach_files#destroy', as: 'attach_files'

end
