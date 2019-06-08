Rails.application.routes.draw do

  concern :voitingable do
    member do
      post :like
      post :dislike
    end
  end

  devise_for :users
  root to: "questions#index"
  resources :questions, concerns: [:voitingable], shallow: true do
    resources :answers, only: [:create, :update, :destroy], concerns: [:voitingable] do
      member { post :best_answer }
    end
  end
  resources :rewards, only: [:index]
  resources :links, only: [:destroy]
  resources :attach_files, only: [:destroy]
end
