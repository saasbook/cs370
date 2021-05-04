# frozen_string_literal: true

class Tutees::RegistrationsController < Devise::RegistrationsController
  layout 'tutee_layout', :only => [:show, :edit, :update]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    #The form for major in tutee registration returns an array whose first element is either Declared or Intended
    #and the second is the actual major (CS, DS, EECS, etc.)
    #tutee_params considers that invalid, so it fails to create the Tutee object
    #I just manually concat, and clone the tutee_params hash bc you can't edit it directly.
    tutee_params[:major] = process_major_input params['tutee']['major']
    flash[:notice] = determine_valid_account Tutee.new(tutee_params)
    redirect_to new_tutee_session_path
  end

  def tutee_params
    params.require(:tutee).permit(:email, :first_name, :last_name, :sid, :gender, :pronoun, :dsp, :transfer, :major, :password, :password_confirmation, :term, ethnicity: [], major: [])
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  #def update
  #  puts account_update_params
  #  super
  #end

  def account_update_params
    # this is a helper used in devise's update function. see comment above in the create function for why this is necessary.
    temp = devise_parameter_sanitizer.sanitize(:account_update)
    temp[:major] = process_major_input params['tutee']['major']
    return temp
  end

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
      sign_in_after_change_password? ? tutee_path(resource) : new_tutee_session_path(resource)
    end
end
