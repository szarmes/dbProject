First_Website::Application.routes.draw do
devise_for :users
 
resources :decks
resources :cards
 
root to: 'static_pages#home'

delete 'decks' => 'decks#destroy', :as => :destroy_decks
delete 'cards' => 'cards#destroy', :as => :destroy_cards
patch  'cards' => 'cards#edit', :as => :edit_cards
    
   # member do
    #  get :following, :followers
    #end
  #end
 # resources :microposts,    only: [:create, :destroy]
 # resources :relationships, only: [:create, :destroy]
  #root  'static_pages#home'
  match '/browse', to: 'browse#index', via: 'get'
  match '/your_decks', to: 'decks#your_decks', via: 'get'
  #match '/new_deck', to: 'decks#create', via: 'post'
  match '/recent_decks', to: 'decks#recent', via: 'get'
  match '/favorite_decks', to: 'decks#favorite', via: 'get'
  match '/favorite_cards', to: 'cards#favorite', via: 'get'
 

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
