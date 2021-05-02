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
    sid_type = identify_sid_type
    sid = identify_sid sid_type

    puts "checking student logged in"
    puts "session params: "+session.to_s
    puts "session id: "+session[sid_type].to_s
    puts "user of type: "+sid_type.to_s
    puts "sid is: "+sid.to_s

    if session[sid_type].to_i != sid.to_i
      puts "not equal"
      if sid_type == :tutee_id
        sign_out 'tutee'
      else
        sign_out 'tutor'
      end
      redirect_to homepage_path
    end
  end

  def identify_sid_type
    if session.has_key?(:tutee_id)
      #tutee check
      return :tutee_id
    elsif session.has_key?(:tutor_id)
      #tutor check
      return :tutor_id
    else
      return nil
    end
  end

  def identify_sid sid_type
    if !params.has_key?(sid_type) and params.has_key?(:id)
      #if on evaluation, then you're a tutee. get tutee id associated with evaluation.
      eval = Evaluation.friendly.find params[:id]
      puts "eval: "
      puts eval.as_json
      puts eval.tutee
      if eval&.tutee
        sid = eval.tutee.id
        puts "sid is now "+sid.to_s
      else
        sid = params[:id]
      end
    else
      sid = params[sid_type]
    end

    return sid
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
