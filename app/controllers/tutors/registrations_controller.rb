# frozen_string_literal: true

class Tutors::RegistrationsController < Devise::RegistrationsController
  layout 'tutor_layout', :only => [:show, :edit, :update]
  before_action :check_valid_tutor, :except => [:new, :create]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    #see comment in tutee/registrations_controller.rb to see why this param stuff is going on
    tutor_params[:major] = process_major_input params['tutor']['major']
    flash[:notice] = determine_valid_account Tutor.new(tutor_params)
    redirect_to new_tutor_session_path
  end

  def tutor_params
    params.require(:tutor).permit(:type_of_tutor, :term, :email, :first_name,
      :last_name, :sid, :gender, :dsp, :transfer, :major, :password, :password_confirmation, major:[])
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   new_tutee_session_path(resource_name)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
   def after_update_path_for(resource)
      sign_in_after_change_password? ? tutor_path(resource) : new_tutor_session_path(resource)
    end
end
