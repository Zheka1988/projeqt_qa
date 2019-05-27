Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"
  resources :questions, shallow: true do
    # member { delete 'links/:id', to: 'links#destroy', as: 'links_destroy' }
    resources :answers, only: [:create, :update, :destroy] do
      member { post :best_answer }

    end
  end
  delete '/links/:id', to: 'links#destroy', as: 'links_destroy'
  delete '/attach_files/:id', to: 'attach_files#destroy', as: 'attach_files'

end
