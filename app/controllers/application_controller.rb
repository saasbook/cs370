class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :sid, :email, :gender, :ethnicity,
                                                        :major, :dsp, :transfer, :term, :pronoun])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :sid, :gender, :pronoun, :dsp, :transfer, :major, :password, :password_confirmation, :term, :ethnicity, :major, ethnicity: [], major: []])
  end

  def after_sign_in_path_for(resource)
  # return the path based on resource
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

  def check_valid_tutee
    #I'm so sorry, but this is what they left me and I didn't have time to fix it.
    #We need to either commit fully to Devise or just don't, cause this is what happens when you try to validate across forms,
    #posts, gets, etc. and everything is split between param ids, nested resource ids, session checks, etc.
    if ['tutees','tutees/registrations'].include? params[:controller] and current_tutee&.id.to_i == params[:id].to_i
    elsif ['requests','meetings','evaluations'].include? params[:controller] and current_tutee&.id.to_i == params[:tutee_id].to_i
    elsif params[:controller] == 'evaluations' and current_tutee&.id.to_i == Evaluation.friendly.find(params[:id])&.tutee.id
    else
      flash[:alert] = "Invalid access, you have been signed out"
      sign_out 'tutee'
      sign_out 'tutor'
      redirect_to homepage_path
    end
  end

  def check_valid_tutor
    if ['tutors','tutors/registrations'].include? params[:controller] and (current_tutor&.id.to_i == params[:id].to_i or current_tutor&.id.to_i == params[:tutor_id].to_i)
    else
      flash[:alert] = "Invalid access, you have been signed out"
      sign_out 'tutor'
      sign_out 'tutee'
      redirect_to homepage_path
    end
  end


  def process_major_input major_array
    return major_array[0]+' '+major_array[1]
  end

  def determine_valid_account new_account
    if new_account.save
      return "Account was successfully created. Please check your email to authenticate your account"
    else
      return "Account was not successfully created"
    end
  end
end
