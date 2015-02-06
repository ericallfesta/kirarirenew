Kirari::Application.routes.draw do

  root to: 'apps#home'
  get "/404", :to => "errors#error_404"
  get "/422", :to => "errors#error_404"
  get "/500", :to => "errors#error_500"
  get :login, to: 'sessions#new', as: :login
  post :login, to: 'sessions#create'
  get :logout, to: 'sessions#destroy'
  get :signup, to: 'users#new', as: :signup
  post :signup, to: 'users#create'

  resources :makers, only: :show

  resources :brands, only: [:index, :show] do
    get :followers, to: 'follows#followers'
    get :products, to: 'products#index'
    resource :follow, controller: :follows, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end

  resources :products, only: [:index, :show] do
    resource :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:show] do
    get :activate, on: :member
    get :following, to: 'follows#following'
    get :followers, to: 'follows#followers'
    resource :follow, controller: :follows, only: [:create, :destroy]
    resources :stamps, only: [:index]
    resource :favorites, only: [:create, :destroy]
  end

  resources :activities, only: [:index]

  %w(diaries reports questions).each do |target|
    get "/activities/#{target}", controller: :activities, action: :typed,
                                 type: target.singularize, as: "activities_#{target}"

    resources target, except: :index do
      resources :comments, only: [:index, :create, :destroy], defaults: { format: :json }, type: target.singularize
      resource :favorites, only: [:create, :destroy]
    end
    get "#{target}/:id", controller: target, action: :redirect, as: "redirect_#{target.singularize}"
  end

  resources :serials, only: [:index, :show] do
    resources :columns, only: [:index]
  end

  resources :columns, only: [:index, :show] do
    get 'all(/:page)', to: 'columns#all', on: :collection, as: :all, defaults: { page: 1 }
  end

  resources :rankings, only: %w[index show] do
    get 'pickup', on: :collection
  end

  resources :notifications, only: :index

  resources :campaigns, only: :index

  resources :requests, only: :create

  resources :categories, only: :index

  resources :news, only: [:index, :show]

  resources :pages, only: [:show]

  resources :request_products, only: [:create]

  # ---- Search Namespace ----

  namespace :search do
    root 'basic#index', as: :basic
    get :result, controller: :basic, action: :result, as: :result
    get :products, controller: :basic, action: :products, as: :products
    get :reports, controller: :basic, action: :reports, as: :reports
    get :diaries, controller: :basic, action: :diaries, as: :diaries
    get :questions, controller: :basic, action: :questions, as: :questions
  end

  # ---- My Namespace ----

  namespace :my do
    resources :users, path: 'profile', as: :profile, only: [:edit, :update] do
      get :reset_password, on: :collection, as: :reset_password
      patch :update_password, on: :collection
    end
    resources :diaries, except: [:index, :show]
    get 'following', action: :following, controller: :follows
    get 'followers', action: :followers, controller: :follows
    resource :follows do
      resources :users, filter: 'users', only: [:create, :destroy], controller: :follows
      post 'brands/:id', to: 'follows#create', filter: 'brands'
      delete 'brands/:id', to: 'follows#destroy', filter: 'brands'
    end
  end

  # ---- Admin Namespace ----

  namespace :admin do
    root to: 'apps#home'
    get :login, to: 'sessions#new'
    resources :sessions, only: [:new, :create]
    resources :products, only: [:show, :edit, :update, :destroy] do
      resources :images, only: [:new, :create, :destroy], controller: 'products/images'

      resources :variations, only: [:new, :create] do
        resources :images, only: [:new, :create, :destroy], controller: 'variations/images'
      end
    end
    resources :variations, only: [:edit, :update, :destroy]
    resources :brands do
      resources :products, only: [:index, :new, :create]
    end
    resources :request_products, only: [:index, :edit, :update, :destroy] do
      resources :products, only: [:new, :create]
    end
    resources :makers
    resources :users, except: [:edit, :update, :destroy] do
      get :reset_password, on: :member
      patch :update_password, on: :member
    end
    resources :categories
    resources :serials, except: [:show] do
      resources :columns, except: [:index, :show]
    end
    resources :news
    resources :columns
    resources :features
    resources :tag_groups
    resources :efficacies, only: [:edit, :update, :destroy]
    resources :tags do
      get :evaluations, on: :member, controller: :evaluations, action: :edit
      patch :evaluations, on: :member, controller: :evaluations, action: :update
      resources :efficacies, only: [:new, :create], controller: :efficacies
    end
    resources :invitations, only: [:new, :create]
    resources :contacts, only: [:new, :create] do
      post :confirm, on: :collection
    end
    resources :search_keywords
    resources :requests, only: [:index, :destroy]
    resources :pages
    resources :popular_keywords, except: [:show]
  end
end
