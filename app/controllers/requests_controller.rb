class RequestsController < ApplicationController

  def index
  end

  def show
    @request = Request.find(params[:id])

  end

  def new
    @tutee = Tutee.find(params[:tutee_id])
    @request = @tutee.requests.new
  end

  def edit
  end

  def create
    @tutee = Tutee.find(params[:tutee_id])
    @request = @tutee.requests.new(request_params)
    @request.course_id = params[:course_id]
    respond_to do |format|
      if @request.save!
        format.html {redirect_to @request, notice: 'Request was successfully created'}
        format.json {render :show, status: :created, location: @request}

      else
        format.html {render :index, notice: '#{request_params}'}
        format.json {render json: @request.errors, status: :unprocessable_entity}
      end
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

  def request_params
    params.require(:request).permit(:tutee_id, :course_id, :subject)
  end
end
