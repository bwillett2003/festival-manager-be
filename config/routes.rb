Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :schedules, only: [:index, :show] do
        delete '/shows/:show_id', to: 'schedules#destroy', as: :remove_show
      end
      resources :users, only: [:index, :show]
    end
  end  
end
