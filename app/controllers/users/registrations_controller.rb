# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    #The form for major in registration returns an array whose first element is either Declared or Intended
    #and the second is the actual major (CS, DS, EECS, etc.)
    #user_params considers that invalid, so it fails to create the User object
    #I just manually concat, and clone the user_params hash bc you can't edit it directly.
    processed_major = user_params
    processed_major[:major] = process_major_input params['user']['major']
    flash[:notice] = determine_valid_account User.new(processed_major)
    redirect_to new_user_session_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :gender, :pronoun, :dsp, :transfer, :major, :password, :password_confirmation, :term, ethnicity: [], major: [])
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  #PUT /resource
  def update
    params[:user][:major] = process_major_input params[:user][:major]
    super
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

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  def after_update_path_for(resource)
    flash[:success] = "Account successfully updated"
    dashboard_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
