Rails.application.routes.draw do

  #resources :admins
  get 'admins/' => 'admins#landing', as: :admin_landing
  get 'admins/home' => 'admins#home', as: :admin_home
  post 'admins/login' => 'admins#createAdminSession', as: :admin_login
  get 'admins/logout' => 'admins#destroyAdminSession', as: :admin_logout
  get 'admins/update_semester' => 'admins#update_semester', as: :admin_update_semester
  post 'admins/current_semester_update' => 'admins#updateCurrentSemester', as: :admin_update_current_semester

  get 'admins/rating_tutors' => 'admins#rating_tutors', as: :admin_rating_tutors
  # post 'admins/statistics_semester_update' => 'admins#updateStatisticsSemester', as: :admin_update_statistics_semester
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, :courses, :requests
  resources :evaluations, only: [:update, :destroy]
  resources :tutees do
    resources :requests
    resources :evaluations
  end

  post 'tutees//login' => 'tutees#createTuteeSession', as: :login_tutee
  get 'tutees/logout' => 'tutees#destroyTuteeSession', as: :logout_tutee

  #post 'tutees/login/' => 'tutees#login', as: :login_tutee
  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee
  get 'evaluations/:id' => 'evaluations#public_show', as: :evaluation_public
  get 'evaluations/:id/edit' => 'evaluations#public_edit', as: :edit_evaluation

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"

  resources :tutors

end
