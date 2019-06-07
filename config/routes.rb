Rails.application.routes.draw do

  devise_for :users
  root to: "questions#index"
  resources :questions, shallow: true do
    member do
      post :like
      post :dislike
    end
    resources :answers, only: [:create, :update, :destroy] do
      member do
        post :best_answer
        post :like
        post :dislike
      end
    end
  end
  resources :rewards, only: [:index]
  resources :links, only: [:destroy]
  resources :attach_files, only: [:destroy]
end
