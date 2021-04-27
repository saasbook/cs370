# frozen_string_literal: true

class Tutors::RegistrationsController < Devise::RegistrationsController
  layout 'tutor_layout', :only => [:show, :edit, :update]
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    @tutor = Tutor.new(tutor_params)
    if @tutor.save
      flash[:notice] = "Account was successfully created. Please check your email to authenticate your account"
    else
      flash[:notice] = "Account was not successfully created"
    end
    redirect_to new_tutor_session_path
  end

  def tutor_params
    params.require(:tutor).permit(:type_of_tutor, :grade_level, :email, :first_name,
      :last_name, :birthday, :sid, :gender, :dsp?, :transfer?, :major, :password, :password_confirmation)
  end

  def classes_params
    BerkeleyClass.all_classes.each do |current_class|
      params[:classes][current_class] = params[:classes].has_key?(current_class) #true hash string => all hash boolean
    end
   params.require(:classes).permit(:CS61A, :CS61B, :CS61C, :CS70, :EE16A, :EE16B, :CS88, :CS10, :DATA8, :UPPERDIV, :OTHER) #maybe store this list as a constant
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
      puts 'resource!!'
      puts resource
      sign_in_after_change_password? ? tutor_path(resource) : new_tutor_session_path(resource)
    end
end
