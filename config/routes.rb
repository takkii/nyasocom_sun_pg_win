Rails.application.routes.draw do
  # devise
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }

  devise_scope :admin do
    get "/admins/sign_out" => "devise/sessions#destroy"
  end

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # if Rails.env.development?
  #   mount LetterOpenerWeb::Engine, at: "/mail/letter/web/open/d018eb4b398a926fb02e6bc89e2d4d8d12da219e7ea6c083a3c9a82e9aec2975/engine/nekotaro/valture/takkii/asdf/ruby/login"
  # end

  # Defines the root path route ("/")
  root "top#index"
  resources :top, only: [:index]
  resource :blog_comments, only: [:create, :destroy]
  resource :users, only: [:show]
  post "/top" => "top#index"
  resources :user, only: [:index, :destroy]
  resources :blogs do
    collection { post :import }
  end
  resources :reblogs, only: [:index]
  resources :comments
  resources :secret, only: [:index], :constraints => Secret.new
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :two_step_verifications, only: [:new, :create]

  # no matches routes
  get  '*unmatched_route', to: 'application#raise_not_found!', format: false
end
