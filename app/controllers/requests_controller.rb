class RequestsController < ApplicationController

  def request_params
    params.require(:request).permit(:tutee_id, :course_id, :subject)
  end

  def index
  end

  def show
  end

  def history
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
      redirect_to new_tutee_request_path, notice:"Invalid request: Subject should be filled out."
    else
      @tutee = Tutee.find_by_id(params[:tutee_id])
      @request = Request.new(request_params)
      @request.tutee_id = @tutee.id
      @request.course_id = request_params[:course_id]
      @request.save!

      flash[:notice] = "Tutoring request for class #{@request.course.name} was successfully created!"
    end

  end

  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html {redirect_to @request, notice: 'Request was successfully updated'}
        format.json {render :show, status: :ok, location: @request}
      else
        format.html {render :edit}
        format.json {render json: @request.errors, status: :unprocessable_entity}
      end
    end
  end
  def destroy
  end

end
