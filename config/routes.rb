Rails.application.routes.draw do
  root to: 'home#index'

  resources :questions do
    member do
      get 'quiz'
      post 'quiz', to: 'questions#check_answer'
    end
  end
end
