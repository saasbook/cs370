Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index", as: :homepage
  post '/welcome/login/' => 'welcome#login', as: :welcome_login
  get  '/welcome/tutor' => 'welcome#tutor', as: :welcome_tutor
  post 'tutees/login/' => 'tutees#login', as: :login_tutee
  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee
  get '/tutees/all/' => 'tutees#all', as: :tutee_all

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  

  resources :tutors
  resources :tutees, :courses
  resources :tutees do
    resources :requests
  end
end

