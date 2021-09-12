Rails.application.routes.draw do

  devise_for :users, controllers: {registrations: 'users/registrations'}, path: ''
  devise_scope :user do
    root to: 'devise/sessions#new', as: :homepage
  end
  get 'dashboard', to: 'users#show'

  resources :requests, only: [:create, :update]
  resources :evaluations, only: [:update]

  get '/match' => 'tutors#match', as: :tutor_match
  post '/confirm_meeting' => 'tutors#confirm_meeting', as: :tutor_confirm_meeting
  post '/finish_meeting' => 'tutors#finish_meeting', as: :tutor_finish_meeting
  delete '/delete_meeting' => 'tutors#delete_meeting', as: :tutor_delete_meeting

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

end
