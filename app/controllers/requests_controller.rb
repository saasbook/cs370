class RequestsController < ApplicationController

  def request_params
    params.require(:request).permit(:tutee_id, :course_id, :subject)
  end

  def index
  end

  def show
  end

  def new
    @tutee = Tutee.find_by_id(params[:id])
    @courses = Course.where(:semester => Course.current_semester)
    @course_array = @courses.all.map { |course| [course.name, course.id] }
  end

  def edit
  end

  def create

    # Checks if parameters are good
    if request_params[:subject].blank?
      flash[:notice] = "Topic cannot be blank"
      redirect_to new_request_path
    end

    p 'request_params'
    p request_params

    @tutee = Tutee.find_by_id(params[:id])
    @request = Request.new(request_params)
    @request.tutee_id = @tutee.id
    @request.course_id = request_params[:course_id]
    @request.save!
    flash[:notice] = "Tutoring request for class #{@request.course.name} was successfully created!"

    # redirect_to tutee_path(@tutee)

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
