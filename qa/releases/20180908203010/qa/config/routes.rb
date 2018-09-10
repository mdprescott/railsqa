Rails.application.routes.draw do
  root 'welcome#index'
  resources :users do
    resources :questions do
      get '/upvote', to: 'questions#upvote', as: 'upvote'
      get '/downvote', to: 'questions#downvote', as: 'downvote'
      resources :answers do
        get '/upvote', to: 'answers#upvote', as: 'upvote'
        get '/downvote', to: 'answers#downvote', as: 'downvote'
        resources :comments
      end
      resources :comments
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
