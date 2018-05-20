Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :courses do
    resources :lectures do
      member do
        get :download
      end 
      member do
        put "like", to: "lectures#upvote"
        put "dislike", to: "lectures#downvote"
      end 
      member do
        put "spam", to: "lectures#spam"
      end  
    end 
  end  
  resources :comments   
  root :to => "courses#index"
  devise_for :users, controllers: { sessions: 'users/sessions' } 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
