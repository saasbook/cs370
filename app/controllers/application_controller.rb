class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :gender, :ethnicity,
                                                        :major, :dsp, :transfer, :term, :pronoun])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :first_name, :last_name, :gender, :pronoun, :dsp, :transfer, :major, :password, :password_confirmation, :term, :ethnicity, :major, ethnicity: [], major: []])
  end

  def after_sign_in_path_for(resource)
    session[:current_user_id] = resource.id
    dashboard_path
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
