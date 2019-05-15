Rails.application.routes.draw do

  devise_for :tutees, controllers: {registrations: 'tutees/registrations'}


  #resources :admins
  root "welcome#index", as: :homepage
  post '/welcome/login/' => 'welcome#login', as: :welcome_login
  get  '/welcome/tutor' => 'welcome#tutor', as: :welcome_tutor
  get '/tutors/:tutor_id/find_students' => 'tutors#find_students', as: :tutor_find_students
  get '/tutors/:tutor_id/requests/email/' => 'requests#email', as: :requests_email_tutor

  get 'admins/' => 'admins#landing', as: :admin_landing
  get 'admins/home' => 'admins#home', as: :admin_home
  post 'admins/login' => 'admins#createAdminSession', as: :admin_login
  get 'admins/logout' => 'admins#destroyAdminSession', as: :admin_logout
  get 'admins/update_semester' => 'admins#update_semester', as: :admin_update_semester
  post 'admins/current_semester_update' => 'admins#updateCurrentSemester', as: :admin_update_current_semester

  get 'admins/rating_tutors' => 'admins#rating_tutors', as: :admin_rating_tutors
  get 'admins/tutor_hours' => 'admins#tutor_hours', as: :admin_tutor_hours
  # post 'admins/statistics_semester_update' => 'admins#updateStatisticsSemester', as: :admin_update_statistics_semester
  get 'admins/courses_update' => 'admins#update_courses', as: :admin_update_courses
  post 'admins/courses_update' => 'admins#post_update_courses', as: :admin_post_update_courses
  get 'admins/update_password' => 'admins#update_password', as: :admin_update_password
  post 'admins/update_password' => 'admins#post_update_password', as: :admin_post_update_password

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, except: [:index, :create, :edit, :new, :update]
  resources :courses, :requests
  resources :evaluations, only: [:update, :destroy]
  resources :tutees do
    resources :requests, except: [:index, :email, :show]
    resources :evaluations
  end

  get 'tutees/login/:id' => 'tutees#createTuteeSession', as: :login_tutee

  get 'requests/history/:tutee_id' => 'requests#history', as: :request_history_tutee
  get 'evaluations/:id' => 'evaluations#public_show', as: :evaluation_public
  get 'evaluations/:id/edit' => 'evaluations#public_edit', as: :edit_evaluation

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :tutors do
    resources :requests, except: [:index, :show, :new, :update]
  end
end

