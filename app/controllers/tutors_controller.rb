class TutorsController < ApplicationController
  before_action :set_tutor, only: [:show, :edit, :update, :destroy]

  # GET /tutors
  # GET /tutors.json
  def index
    @tutors = Tutor.all
  end

  # GET /tutors/1
  # GET /tutors/1.json
  def show
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
          format.html { redirect_to tutor_path(@tutor.id)}
        end
      else
        flash[:notice] = "Tutor was not successfully created."
        redirect_to new_tutor_path
      end
    end

  # PATCH/PUT /tutors/1
  # PATCH/PUT /tutors/1.json
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
        puts "on show page"
        format.html { redirect_to @tutor, notice: 'Tutor was successfully updated.' }
        format.json { render :show, status: :ok, location: @tutor }
      else
        puts "on edit page"
        format.html { render :edit }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1
  # DELETE /tutors/1.json
  def destroy
    @tutor.destroy
    respond_to do |format|
      format.html { redirect_to tutors_url, notice: 'Tutor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    VALID_EMAIL_REGEX = /A[\w+\-.]+@berkeley.edu/

    def set_tutor
      @tutor = Tutor.find(params[:id])
      @all_classes = BerkeleyClass.all_classes 
      @class_obj = BerkeleyClass.find(@tutor.berkeley_classes_id)
      @true_classes = @class_obj.true_classes
    end

    def validate_email (email)
      /\A[\w+\-.]+@berkeley.edu/.match(email)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tutor_params
      params.require(:tutor).permit(:type_of_tutor, :grade_level, :classes_id, :email, :first_name, :last_name)
    end

    def classes_params
      BerkeleyClass.all_classes.each do |current_class|
        params[:classes][current_class] = params[:classes].has_key?(current_class) #true hash string => all hash boolean 
      end
     params.require(:classes).permit(:CS61A, :CS61B, :CS61C, :CS70, :EE16A, :EE16B, :CS88, :CS10, :DATA8) #maybe store this list as a constant
    end
end
