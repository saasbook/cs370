Rails.application.routes.draw do

  get 'evaluations/new'
  get 'evaluations/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, :courses
  resources :tutees do
    resources :requests
  end
  post 'tutees/login/' => 'tutees#login', as: :login_tutee
  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee


  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root "welcome#index"

  resources :tutors

end

