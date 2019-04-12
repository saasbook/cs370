class TuteesController < ApplicationController

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun)
  end

  def index

  end

  def show
    id = params[:id]
    @tutee = Tutee.find(id)
  end

  def new
    # default: render 'new' template if they have not logged in before
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
    elsif not tutee_params[:email].ends_with? "@berkeley.edu"
      flash[:message] = "Invalid email, ensure email ends with @berkeley.edu."
      redirect_to new_tutee_path
      return
    end

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
    elsif not tutee_params[:email].ends_with? "@berkeley.edu"
      flash[:message] = "Invalid email, ensure email ends with @berkeley.edu."
      redirect_to edit_tutee_path(@tutee)
      return
    end

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
