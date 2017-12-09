Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'events#index'

  get '/events', to: 'events#show_events_by_date', as: :events_by_date
end
