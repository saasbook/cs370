class RequestsController < ApplicationController

  def request_params
    params.require(:request).permit(:tutee_id, :course_id, :subject)
  end

  def index
    @requests = Request.all
    @tutor = Tutor.find_by_id(params[:tutor_id])
  end

  def show
  end

  def history
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @requests = Request.where(:tutee_id => params[:tutee_id])
  end

  def new
    @tutee = Tutee.find_by_id(params[:tutee_id])
    @courses = Course.where(:semester => Course.current_semester)
    @course_array = @courses.all.map { |course| [course.name, course.id] }
  end

  def edit
  end

  def create

    # Checks if parameters are good
    if request_params[:subject].blank?
      flash[:message] = "Invalid request: Subject should be filled out."
      redirect_to new_tutee_request_path
      return
    else
      @tutee = Tutee.find_by_id(params[:tutee_id])
      @request = Request.new(request_params)
      @request.tutee_id = @tutee.id
      @request.course_id = request_params[:course_id]
      @request.save!

      flash[:message] = "Tutoring request for class #{@request.course.name} was successfully created!"
    end
    redirect_to tutee_path(@tutee)
  end

  def update
    # respond_to do |format|
    #   if @request.update(request_params)
    #     format.html {redirect_to @request, notice: 'Request was successfully updated'}
    #     format.json {render :show, status: :ok, location: @request}
    #   else
    #     format.html {render :edit}
    #     format.json {render json: @request.errors, status: :unprocessable_entity}
    #   end
    # end
  end
  def destroy
  end
    # t.bigint "tutor_id"
    # t.bigint "request_id"

  def email
    tid = params[:tutor_id]
    sid = params[:student][:id]
    requestid = params[:student][:requestid]
    tutor_message = params[:tutor][:text_area].html_safe 
    Meeting.create({:tutor_id => tid.to_i, :request_id => requestid.to_i});
    TutorMailer.invite_student(tid, sid, tutor_message, requestid).deliver_now
    redirect_to tutor_requests_path(tid)
  end

end