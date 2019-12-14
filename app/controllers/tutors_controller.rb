require 'date'
class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :find_students]
  before_action :check_tutor_logged_in, only: [:index, :show]


  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  def find_students
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find_by_id(params[:id])
    @meetings = Meeting.where("set_time > ? and tutor_id = ?", Time.now, params[:id])

    @test = Request.all
    @testing = @test.map{|req| req.evaluation.nil?}
    @abc = @testing.last

    @meeting_times = @meetings.map{|meet| meet.set_time.strftime("on %A %d at %l:%M %p")}
    @meeting_locations = @meetings.map{|meet| meet.set_location.titleize}
    @meeting_evals = @meetings.map{|meet| Evaluation.find_by_id(meet.evaluation_id)}
    @meeting_evals_status = @meeting_evals.map{|eval| eval.status}
    @meeting_evals_took_place = @meeting_evals.map{|eval| eval.took_place}
    @meeting_tutees = @meetings.map{|meet| Tutee.find_by_id(meet.tutee_id)}
    @meeting_emails = @meeting_tutees.map{|tutee| tutee.email}
    @meeting_names = @meeting_tutees.map{|tutee| tutee.first_name + " " + tutee.last_name}
    
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
    @berkeley_classes = BerkeleyClass.all_classes
  end

  # GET /tutors/1/edit
  def edit
  end

  # POST /tutors
  # POST /tutors.json
  def create
    @tutor = Tutor.new(tutor_params)
    if params[:classes].blank?
      flash[:notice] = "You must select at least one class."
      redirect_to new_tutor_path
      return
    end
    @bc = BerkeleyClass.new(classes_params)
    @bc.save
    @tutor.berkeley_classes_id = @bc.id
    if @tutor.save
      # flash[:notice] = "#{@tutor.first_name} #{@tutor.last_name} was successfully created."
      respond_to do |format|
        flash[:notice] = "#{@tutor.first_name} #{@tutor.last_name} was successfully created."
        params[:id] = @tutor.id
        format.html { redirect_to tutor_path(@tutor.id)}
      end
    else
      flash[:notice] = "Tutor was not successfully created."
      redirect_to new_tutor_path
    end
  end

  def total_hours
    @tutor= Tutor.find(params[:id])
    return Tutor.total_hours_helper(@tutor)
  end
  helper_method :total_hours


  def hours_this_week
    @tutor= Tutor.find(params[:id])
    return Tutor.hours_this_week_helper(@tutor)
  end
  helper_method :hours_this_week

  def average_hours
    @tutor= Tutor.find(params[:id])


    return Tutor.average_hours_helper(@tutor)


  end
  helper_method :average_hours

  def update
    tutor = params[:tutor]
    email = tutor[:email]
    classes = params[:classes]

    if classes.blank?
      flash[:notice] = "Preferred Classes cannot be blank."
      redirect_to edit_tutor_path(@tutor.id)
      return
    end

    respond_to do |format|
      if @tutor.update(tutor_params) && @class_obj.update(classes_params)
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

  end

  def requests

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    VALID_EMAIL_REGEX = /A[\w+\-.]+@berkeley.edu/

    def set_tutor
      if params[:id] == "sign_out" || params[:id] == "new" 
        redirect_to new_tutor_session_path
      else
        if params[:id]
          @tutor = Tutor.find(params[:id])
        else
          @tutor = Tutor.find(params[:tutor_id])
        end
        @all_classes = BerkeleyClass.all_classes
        @class_obj = BerkeleyClass.find(@tutor.berkeley_classes_id)
        @true_classes = @class_obj.true_classes
      end
    end

    def validate_email (email)
      /\A[\w+\-.]+@berkeley.edu/.match(email)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:type_of_tutor, :grade_level, :email, :first_name,
        :last_name, :birthday, :sid, :gender, :dsp?, :transfer?, :major)
    end

    def classes_params
      BerkeleyClass.all_classes.each do |current_class|
        params[:classes][current_class] = params[:classes].has_key?(current_class) #true hash string => all hash boolean
      end
     params.require(:classes).permit(:CS61A, :CS61B, :CS61C, :CS70, :EE16A, :EE16B, :CS88, :CS10, :DATA8) #maybe store this list as a constant
    end


end
