SampleApp::Application.routes.draw do

  get "contacts/new"
  resources :users do
     member do
        get :following, :followers
     end
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :contacts, only: [:new, :create]

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',   via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete' 
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

# facebookのログイン・認証が完了した後のリダイレクト先(auth/facebook/callback)とsession#createを紐づけ
  match 'auth/:provider/callback', to: 'session#create', via: [:get, :post]

# facebookのログイン・認証が失敗した後のリダイレクト先(auth/failure)とrootを紐づけ
  match 'auth/failure', to: redirect('/'), via: [:get, :post]

# signout_urlとsession#destroyを紐づけ
  # match 'signout', to: 'session#destroy', as: 'signout', via: [:get, :post]
  
# deviseを使う際のfacebookログイン認証機能用は以下。
  # devise_scope :user do
  # get 'sign_in',  to: 'users/sessions#new',     as: :new_user_session
  # get 'sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
  # end

  # devise_for :users, controllers: { 
  # omniauth_callbacks: "some_dir/omniauth_callbacks" }
#ここまで 

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
