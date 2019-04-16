class TuteesController < ApplicationController

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun)
  end

  def login
    if not params[:email].downcase.ends_with? "@berkeley.edu"
      redirect_to tutees_path
      return
    end
    @tutee = Tutee.where(:email => params[:email].downcase).first()
    if not @tutee.nil?
      redirect_to tutee_path(@tutee)
      return
    end

    redirect_to new_tutee_path
  end
  def index

  end

  def show
    @courses = [Course.find_by_semester(Course.current_semester)]

    # @courses = Course.find_by_semester(Course.current_semester).pluck(:name, :semester)
    @tutee = Tutee.find_by_id(params[:id])
  end

  def new
  end

  def edit
    @tutee = Tutee.find params[:id]
  end

  def create
    # Checks if parameters are good
    if tutee_params[:first_name] == "" or tutee_params[:last_name] == ""
      flash[:message] = "First Name or Last Name left blank."
      redirect_to new_tutee_path
      return
    elsif tutee_params[:first_name] =~ /\d/ or tutee_params[:last_name] =~ /\d/
      flash[:message] = "No digits in first or last name."
      redirect_to new_tutee_path
      return
    elsif tutee_params[:sid].blank?
      flash[:message] = "SID field cannot be left empty"
      redirect_to new_tutee_path
      return
    elsif not tutee_params[:email].downcase.ends_with? "@berkeley.edu"
      flash[:message] = "Invalid email, ensure email ends with @berkeley.edu."
      redirect_to new_tutee_path
      return
    elsif not tutee_params[:birthdate].match(/\d{4}-\d{2}-\d{2}/) or tutee_params[:birthdate] == "" or tutee_params[:birthdate] > Time.now.strftime("%Y-%m-%d")
      flash[:message] = "Invalid date or date format, or empty date field. #{tutee_params[:birthdate]}"
      redirect_to new_tutee_path
      return
    end
    tutee_params[:email] = tutee_params[:email].downcase!
    @tutee = Tutee.create!(tutee_params)
    flash[:message] = "Account for #{@tutee.first_name} was successfully created."

    if @tutee.valid?
      redirect_to tutee_path(@tutee)
    else
      redirect_to tutees_path
    end
  end

  def update
    @tutee = Tutee.find params[:id]

    # Checks if parameters are good
    if tutee_params[:first_name] == "" or tutee_params[:last_name] == ""
      flash[:message] = "First or Last name left cannot be left blank."
      redirect_to edit_tutee_path(@tutee)
      return
    elsif tutee_params[:first_name] =~ /\d/ or tutee_params[:last_name] =~ /\d/
      flash[:message] = "No digits in first or last name."
      redirect_to edit_tutee_path(@tutee)
      return
    elsif tutee_params[:sid].blank?
      flash[:message] = "SID field cannot be left empty"
      redirect_to edit_tutee_path(@tutee)
      return
    elsif not tutee_params[:email].downcase.ends_with? "@berkeley.edu"
      flash[:message] = "Invalid email, ensure email ends with @berkeley.edu."
      redirect_to edit_tutee_path(@tutee)
      return
    elsif not tutee_params[:birthdate].match(/\d{4}-\d{2}-\d{2}/) or tutee_params[:birthdate] == "" or tutee_params[:birthdate] > Time.now.strftime("%Y-%m-%d")
      flash[:message] = "Invalid date or date format, or empty date field."
      redirect_to edit_tutee_path(@tutee)
      return
    end
    tutee_params[:email] = tutee_params[:email].downcase!
    if @tutee.update!(tutee_params)
      flash[:message] = "information was successfully updated."
      redirect_to tutee_path(@tutee)
    else
      redirect_to edit_tutee_path(@tutee)
    end
  end

  def destroy
  end
end
