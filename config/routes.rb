Rails.application.routes.draw do

  get 'todos/show'

  devise_for :contacts
  devise_for :users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)
  namespace :admin do
    resources :projects, only: [:index] do
      resources :todos
    end
    resources :services, only: [:index] do
      resources :todos
    end
    resources :attachments, only: [:show]
  end
  
  root to: "dashboards#show", constraints: lambda { |request| request.subdomain.present? && request.subdomain != 'www' }
  root to: "pages#home"
  put "/dashboard/dismiss_welcome", to: 'dashboards#dismiss_welcome', as: 'dismiss_welcome'
  get "/help", to:'pages#help'
  post "/email_update", to:'profiles#email_update'
  
  resource :dashboard, only: [:show]
  resource :profile, only: [:show, :edit, :update]
  resources :resources, only: [:index, :show]
  resources :logins, except: [:index]
  resources :services, only: [:show]
  resources :reports, only: [:show]
  resources :projects, only: [:show]
  resources :todos, only: [:show, :update] do
    resources :attachments, only: [:new, :create, :destroy], controller: 'todos/attachments'
    resources :comments, only: [:create, :destroy], controller: 'todos/comments'
  end

end
