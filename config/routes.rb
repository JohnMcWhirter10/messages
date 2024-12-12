Rails.application.routes.draw do
  root 'messages#index'

  resources :messages do
    member do
      delete :remove_video
      delete :remove_thumbnail
    end
  end
  
end
