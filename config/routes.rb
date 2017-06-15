Rails.application.routes.draw do
  resources :taggings, only: :destroy
  resources :products do
    resources :tags, only: :create
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
