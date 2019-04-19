Rails.application.routes.draw do

  #resources :admins
  get 'admins/' => 'admins#landing', as: :admin_landing
  get 'admins/home' => 'admins#home', as: :admin_home
  post 'admins/login' => 'admins#createAdminSession', as: :admin_login
  get 'admins/logout' => 'admins#destroyAdminSession', as: :admin_logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, :courses
  resources :tutees do
    resources :requests
  end

  post 'tutees/login_session' => 'tutees#createTuteeSession', as: :login_tutee
  get 'tutees/logout' => 'tutees#destroyTuteeSession', as: :logout_tutee

  #post 'tutees/login/' => 'tutees#login', as: :login_tutee
  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee


  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  root "welcome#index"

  resources :tutors

end

