# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'articles/articles#index'

  namespace :articles do
    resources :articles, only: :index do
      collection do
        get :fetch
      end
    end
  end
end
