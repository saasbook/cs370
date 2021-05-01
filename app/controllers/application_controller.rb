class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :sid, :email, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :sid, :email, :gender, :ethnicity,
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
    homepage_path
  end

  def check_student_logged_in
    sid_type = ''
    if session.has_key?(:tutee_id)
      #tutee check
      sid_type = :tutee_id
    elsif session.has_key?(:tutor_id)
      #tutor check
      sid_type = :tutor_id
    else
      redirect_to homepage_path
      return
    end

    sid = params.has_key?(sid_type) ? params[sid_type] : -1
    if sid == -1 and params.has_key?(:id)
      sid = params[:id]
    end

    if session[sid_type].to_i != sid.to_i
      if sid_type == :tutee_id
        sign_out 'tutee'
      else
        sign_out 'tutor'
      end
      redirect_to homepage_path
    end
  end

  def process_major_input major_array
    return major_array[0]+' '+major_array[1]
  end
end
