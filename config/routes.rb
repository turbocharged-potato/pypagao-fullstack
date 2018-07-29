# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'courses#index'

  resources :users
  
  resources :courses, only: %i[index new create] do
    resources :semesters, shallow: true, only: %i[index new create] do
      resources :papers, shallow: true, only: %i[index new create] do
        resources :questions, shallow: true, only: %i[index new create] do
          resources :answers, shallow: true, only: %i[index new create] do
            resources :comments, shallow: true, only: %i[index new create]
            resources :votes, shallow: true
          end
        end
      end
    end
  end
end
