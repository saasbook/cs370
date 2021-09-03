Rails.application.routes.draw do

  devise_for :users
  devise_for :tutors, controllers: {registrations: 'tutors/registrations'}, skip:['sessions']
  devise_for :tutees, skip:['registrations','sessions']
  devise_scope :tutor do
    get '/' => 'welcome#index', as: :new_tutor_session
    post '/tutors/sign_in' => 'devise/sessions#create', as: :tutor_session
    delete '/tutors/sign_out' => 'devise/sessions#destroy', as: :destroy_tutor_session
  end

  devise_scope :tutee do
    get '/' => 'welcome#index', as: :new_tutee_session
    post '/tutees/sign_in' => 'devise/sessions#create', as: :tutee_session
    delete '/tutees/sign_out' => 'devise/sessions#destroy', as: :destroy_tutee_session

    get '/tutees/cancel' => 'tutees/registrations#cancel', as: :cancel_tutee_registration
    get '/tutees/sign_up' => 'tutees/registrations#new', as: :new_tutee_registration
    get '/tutees/:id/edit' => 'tutees/registrations#edit', as: :edit_tutee_registration
    patch '/tutees/:id' => 'tutees/registrations#update', as: :tutee_registration
    put '/tutees/:id' => 'tutees/registrations#update'
    post '/tutees/' => 'tutees/registrations#create'
  end

  get 'tutees/:tutee_id/meetings' => 'meetings#show', as: :tutee_meetings
  get 'tutees/:tutee_id/history' => 'requests#history', as: :request_history_tutee

  root "welcome#index", as: :homepage
  get '/welcome/get_login_form/' => 'welcome#get_login_form', as: :welcome_get_login_form
  get '/tutors/:tutor_id/match' => 'tutors#match', as: :tutor_match
  post '/tutors/:tutor_id/confirm_meeting' => 'tutors#confirm_meeting', as: :tutor_confirm_meeting
  post 'tutors/:tutor_id/meetings/:meeting_id' => 'tutors#finish_meeting', as: :meetings_done
  delete 'tutors/:tutor_id/meetings/:meeting_id' => 'tutors#delete_meeting', as: :tutor_delete_meeting

  get 'admins/home' => 'admins#home', as: :admin_home
  post '/' => 'admins#createAdminSession', as: :admin_login
  get '/' => 'admins#destroyAdminSession', as: :admin_logout
  get 'admins/manage_semester' => 'admins#manage_semester', as: :admin_manage_semester
  get 'admins/toggle_signups' => 'admins#toggle_signups', as: :admin_toggle_signups
  get 'admins/close_unmatched_requests' => 'admins#close_unmatched_requests', as: :admin_close_unmatched_requests
  post 'admins/update_tutor_types' => 'admins#update_tutor_types', as: :admin_update_tutor_types

  get 'admins/rating_tutors' => 'admins#rating_tutors', as: :admin_rating_tutors
  get 'admins/tutor_hours' => 'admins#tutor_hours', as: :admin_tutor_hours
  get 'admins/manage_tutors' => 'admins#manage_tutors', as: :admin_manage_tutors
  post 'admins/manage_tutors/delete_tutor' => 'admins#delete_tutor', as: :admin_delete_tutor
  get 'admins/export_table' => 'admins#export_table', as: :admin_export_table
  post 'admins/update_courses' => 'admins#update_courses', as: :admin_update_courses
  get 'admins/update_password' => 'admins#update_password', as: :admin_update_password
  post 'admins/update_password' => 'admins#post_update_password', as: :admin_post_update_password

  #Admin customize QuestionTemplates routes
  get 'admins/update_question_templates' => 'admins#update_question_templates', as: :admin_update_question_templates
  post 'admins/batch_update' => 'question_templates#batch_update', as: :question_templates_batch_update
  get 'question_templates/get_details' => 'question_templates#get_details'
  get 'question_templates/new' => 'question_templates#new'

  #Used to update Question values (probably just the :response) in Evaluation#update
  patch 'questions/update_response' => 'questions#update_response', as: :question
  put 'questions/update_response' => 'questions#update_response'

  get 'meetings/panel_info' => 'meetings#panel_info'
  get 'evaluations/view_responses' => 'evaluations#view_responses'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tutees, only: [:show]
  resources :evaluations, only: [:update, :destroy]
  resources :tutees do
    resources :requests, only: [:create, :new, :edit]
    resources :evaluations, only: [:index, :show, :edit, :update]
  end

  resources :tutors, except: [:index, :new]

end
