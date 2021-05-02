require 'date'
class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :find_students, :current_url_without_parameters]
  before_action :check_tutor_logged_in, except: [:index, :new, :create, :confirm_meeting]


  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  def finish_meeting
    @meeting = Meeting.find_by_id(params[:meeting_id])
    @meeting.is_done = true
    @meeting.save!

    tid = params[:tutor_id]
    sid = @meeting.tutee_id

    begin
      TutorMailer.meeting_complete_notice(tid, sid).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out emails."
    end

   flash[:notice] = "Your meeting was successfully finished."
   redirect_back(fallback_location:"/")
  end

  def delete_meeting
    @meeting = Meeting.find_by_id(params[:meeting_id])
    @eval = Evaluation.find_by_id(@meeting.evaluation_id)
    @meeting.destroy!
    @eval.destroy!

    flash[:notice] = "Your meeting was successfully cancelled."
    redirect_back(fallback_location:"/")
  end

  def confirm_meeting
    tid = params[:tutor_id]

    @time = Time.strptime(params["Date"] + params["Time"], "%Y-%m-%d%H:%M")
    @loc = params["Location"]

    tutor_message = "Hi, your meeting has been confirmed for " + @time.strftime("%A, %b %d at %l:%M %p") + " at " + @loc + "."
    @meeting = Meeting.find_by_id(params[:meeting_id])
    @meeting.set_time = @time
    @meeting.set_location = @loc
    @meeting.is_scheduled = true
    @meeting.save!

    sid = @meeting.tutee_id
    requestid = @meeting.request_id
    eval_id = @meeting.evaluation_id
    begin
      TutorMailer.meeting_confirmation(tid, sid, tutor_message, requestid, eval_id).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out confirmation emails."
    end
    flash[:notice] = "Successfully confirmed meeting details!"
    redirect_to tutor_path(tid)
  end

  def match
    tid = params[:tutor_id]
    sid = params[:student][:id]
    requestid = params[:student][:requestid]
    #tutee_id = params[:tutee_id]
    #tutor_message = "Hi, your request was matched to a tutor. Please agree on a time and location using email. The tutor will then need to input those details on the cs370 website."
    @eval = Evaluation.create!()

    @meeting = Meeting.create({:tutor_id => tid.to_i, :request_id => requestid.to_i, :evaluation_id => @eval.id, :tutee_id => sid});
    begin
      TutorMailer.invite_student(tid, sid, requestid, @eval.id).deliver_now
    rescue StandardError
      flash[:alert] = "An error occured when sending out emails."
    end
    flash[:notice] = "Successfully matched!"
    redirect_back(fallback_location:"/")
  end

  def find_students
    if params.has_key?(:class)
      @selected_class = params[:class]
    else
      @selected_class = [Course.find_by_semester(Course.current_semester)][0]
    end
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
    @tutor = Tutor.find_by_id(params[:id])
    @meetings = Meeting.where("tutor_id = ? AND is_done = FALSE", params[:id])
    @test = Request.all
    @testing = @test.map{|req| req.evaluation.nil?}
    @abc = @testing.last  
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
     params.require(:classes).permit(:CS61A, :CS61B, :CS61C, :CS70, :EE16A, :EE16B, :CS88, :CS10, :DATA8, :UPPERDIV, :OTHER) #maybe store this list as a constant
    end

    def current_url_without_parameters
      @base_url = request.base_url + "/tutors/2/find_students"
    end


end
