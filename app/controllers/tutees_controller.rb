class TuteesController < ApplicationController
  layout 'tutee_layout', :only => [:show, :edit]
  # Authorization section
  #before_action :set_tutee, expect: [:index,:login, :createTuteeSession, :new, :create]
  # skip_before_action :verify_authenticity_token, only: [:createTuteeSession]
  before_action :check_tutee_logged_in, except: [:index, :login, :createTuteeSession, :new, :create]

  # def createTuteeSession
  #   #Add authentication here in the future
  #   @tutee = Tutee.find_by_id(params[:id])
  #   if @tutee.nil?
  #     redirect_to new_tutee_registration_path
  #   elsif @tutee
  #     add_tutee_to_session(@tutee)
  #   else
  #     new_tutee_session_path
  #   end
  # end

  # def destroyTuteeSession
  #   session[:tutee_logged_in] = false
  #   session[:tutee_id] = nil
  #   redirect_to destroy_tutee_session_path, method: :delete


  # end


  def tutee_params
  #   params.require(:tutee).permit(:first_name, :last_name, :sid, :privilege, :email, :birthdate, :gender, :ethnicity,
  #                                 :major, :dsp, :transfer, :year, :pronoun)
  end

  def login
    # @tutee = Tutee.find_by_id(params[:id])
    # redirect_to tutee_path(@tutee)
  end

  def index
  end

  def show
    @courses = [Course.find_by_semester(Course.current_semester)]
    @tutee = Tutee.find_by_id(params[:id])
    @requests = @tutee.requests.where('created_at >= ?', Date.today.beginning_of_week.strftime("%Y-%m-%d"))
    @evaluations = @tutee.evaluations
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  # private
  #   def set_tutee
  #     @tutee = Tutee.find_by_id(session[:tutee_id])
  #   end


    # def add_tutee_to_session tutee
    #   session[:tutee_id] = @tutee.id
    #   redirect_to tutee_path(@tutee)
    # end
end
