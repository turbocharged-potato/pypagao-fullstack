# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'universities#index'

  resources :users, only: %i[show index]
  resources :universities, only: %i[index create] do
    resources :courses, shallow: true, only: %i[index create] do
      resources :semesters, shallow: true, only: %i[index create] do
        resources :papers, shallow: true, only: %i[index create] do
          resources :questions, shallow: true, only: %i[index create] do
            resources :answers, shallow: true, only: %i[index create update destroy] do
              post '/votes/up', to: 'votes#up'
              post '/votes/down', to: 'votes#down'
              resources :comments, shallow: true, only: %i[index create update destroy]
            end
          end
        end
      end
    end
  end
end
