Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, :courses
  resources :tutees do
    resources :requests
  end
  post '/tutors/login/' => 'tutors#login', as: :login_tutor
  get  '/welcome/tutor' => 'welcome#tutor', as: :welcome_tutor
  post 'tutees/login/' => 'tutees#login', as: :login_tutee
  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee


  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root "welcome#index", as: :homepage

  resources :tutors

end

