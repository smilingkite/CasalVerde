# frozen_string_literal: true
Rails.application.routes.draw do

  root to: 'pages#index'

  devise_for :users

  resources :pages, only: [:index, :show] do
    get :photogallery, on: :collection
    get :prices, on: :collection
  end
  resources :reviews

  resources :photos
  resources :bookings, only: [:new, :create, :show] do
    get :taken, on: :collection
  end

  resources :prices, only: [:calculate_price] do
    post :calculate_price, on: :collection
  end

  namespace :admin do
    get '/', to: 'panel#index'
    get '/past_bookings', to: 'bookings#past', as: 'past_bookings'
    resources :prices, except: [:show, :new]
    resources :bookings, only: [:index, :update, :delete]
    resources :reviews, only: [:index, :destroy]
    resources :photos, except: [:show, :edit, :new]
    resources :pages, except: [:show, :edit, :new] do
      resources :paragraphs, except: [:show, :edit, :new]
    end
  end

  namespace :api do
    resources :pages do
      resources :paragraphs
    end

    # resources :bookings
  end

end
