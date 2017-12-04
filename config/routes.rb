Rails.application.routes.draw do
  resources :questions do
    member do
      get 'quiz'
      post 'quiz', to: 'questions#check_answer'
    end
  end
end
