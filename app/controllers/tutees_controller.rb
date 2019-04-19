module TuteesHelper
  def validInputs? tutee_params
    if nameValid? tutee_params and sidValid? tutee_params and emailValid? tutee_params and birthdateValid? tutee_params
      return true
    end
    return false
  end
  def nameValid? tutee_params
    if tutee_params[:first_name] == "" or tutee_params[:last_name] == "" or
        tutee_params[:first_name] =~ /\d/ or tutee_params[:last_name] =~ /\d/
      return false
    end
    return true
  end
  def sidValid? tutee_params
    if tutee_params[:sid].blank?
      return false
    end
    return true
  end
  def emailValid? tutee_params
    if not tutee_params[:email].ends_with? "@berkeley.edu" or tutee_params[:email].blank?
      return false
    end
    return true
  end
  def birthdateValid? tutuee_params
    if not tutee_params[:birthdate].match(/\d{4}-\d{2}-\d{2}/) or tutee_params[:birthdate] == "" or tutee_params[:birthdate] > Time.now.strftime("%Y-%m-%d")
      return false
    end
    return true
  end
end

class TuteesController < ApplicationController
  include TuteesHelper

  # Authorization section
  before_action :set_tutee, expect: [:index,:login, :createTuteeSession, :new, :create]
  # before_action :check_logged_in, except: [:index, :login, :createTuteeSession, :new, :create]

  def landing
  end

  def createTuteeSession
    #Add authentication here in the future
    @tutee = Tutee.where(:email => params[:email].downcase).first()
    if @tutee.nil?
      redirect_to new_tutee_path
    elsif @tutee #and @tutee.authenticate(params[:password])
      session[:tutee_logged_in] = true
      session[:tutee_id] = @tutee.id
      redirect_to tutee_path(@tutee)
    else
      redirect_to tutees_path
    end
  end

  def destroyTuteeSession
    session[:tutee_logged_in] = false
    session[:tutee_id] = nil
    redirect_to tutees_path
  end

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun)
  end

  # def login
  #   @tutee = Tutee.where(:email => params[:email].downcase).first()
  #   if not @tutee.nil? then redirect_to tutee_create_session_path(@tutee) else redirect_to new_tutee_path end
  # end

  def index
  end

  def show
    @tutee = Tutee.find params[:id]
    @courses = [Course.find_by_semester(Course.current_semester)]
    @requests = Request.where(:tutee_id => session[:tutee_id])
    #@tutee = Tutee.find_by_id(params[:id])
  end

  def new
  end

  def edit
    # @tutee = Tutee.find params[:id]
  end

  def create
    tutee_params[:email] = tutee_params[:email].downcase!
    if validInputs? tutee_params
      @tutee = Tutee.create!(tutee_params)
      flash[:message] = "Account for #{@tutee.first_name} was successfully created."
      redirect_to tutee_create_session_path(@tutee)
    else
      flash[:message] = "Invalid Inputs"
      redirect_to new_tutee_path
    end
  end

  def update
    @tutee = Tutee.find params[:id]
    tutee_params[:email] = tutee_params[:email].downcase!

    if validInputs? tutee_params
      @tutee.update!(tutee_params)
      flash[:message] = "Information was successfully updated."
      redirect_to tutee_path(@tutee)
    else
      flash[:message] = "Invalid Inputs"
      redirect_to edit_tutee_path(@tutee)
    end
  end

  private
    def set_tutee
      @tutee = Tutee.find_by_id(session[:tutee_id])
    end
    def check_logged_in
      if session[:tutee_logged_in].nil? or not session[:tutee_logged_in] or session[:tutee_id].nil?
        redirect_to tutees_path
      end
    end
end
