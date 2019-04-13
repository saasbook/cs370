Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, :courses, :requests

  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee
  get 'tutees/:id' => 'tutees#show', as: :tutee_homepage
end
