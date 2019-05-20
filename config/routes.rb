Rails.application.routes.draw do
  devise_for :users
  root to: "questions#index"
  resources :questions, shallow: true do
    resources :answers, only: [:create, :update, :destroy] do
      member { post :best_answer }
      member { delete :delete_attach_file}
    end
    member { delete :delete_attach_file}
  end
end
