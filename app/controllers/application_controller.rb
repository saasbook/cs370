class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :sid, :privilege, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :sid, :privilege, :email, :birthdate, :gender, :ethnicity,
                                                       :major, :dsp, :transfer, :year, :pronoun])
  end

  def after_sign_in_path_for(resource)
  # return the path based on resource
    puts resource
    if resource.is_a? Tutor
      session[:tutor_id] = resource.id
      tutor_path(current_tutor)
    else
      session[:tutee_id] = resource.id
      tutee_path(current_tutee)
    end
  end

  def after_sign_out_path_for(resource)
    session[:tutee_logged_in] = false
    session[:tutee_id] = nil
    session[:tutor_logged_in] = false
    session[:tutor_id] = nil
    if resource == :tutee
      new_tutee_session_path
    else
      new_tutor_session_path
    end
  end

  def check_tutee_logged_in
    tutee_id = params.has_key?(:tutee_id) ? params[:tutee_id] : -1
    if tutee_id == -1 and params.has_key?(:id)
      tutee_id = params[:id]
    end

    if !(session[:tutee_id].to_i == tutee_id.to_i)
      sign_out :tutee
      redirect_to new_tutee_session_path
    end
  end

  def check_tutor_logged_in
    tutor_id = params.has_key?(:tutor_id) ? params[:tutor_id] : -1
    if tutor_id == -1 and params.has_key?(:id)
      tutor_id = params[:id]
    end

    if !(session[:tutor_id].to_i == tutor_id.to_i)
      sign_out :tutor
      redirect_to new_tutor_session_path
    end
  end

end
