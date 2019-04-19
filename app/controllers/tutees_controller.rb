module TuteesHelper
  def birthdateValid? tutuee_params
    if tutee_params[:birthdate] > Time.now.strftime("%Y-%m-%d") #not tutee_params[:birthdate].match(/\d{4}-\d{2}-\d{2}/) or tutee_params[:birthdate] == "" or
      return false
    end
    return true
  end
end

class TuteesController < ApplicationController
  include TuteesHelper

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email, :birthdate, :gender, :ethnicity,
                                  :major, :dsp, :transfer, :year, :pronoun)
  end

  def login
    @tutee = Tutee.where(:email => params[:email].downcase).first()
    if not @tutee.nil? then redirect_to tutee_path(@tutee) else redirect_to new_tutee_path end
  end

  def index
  end

  def show
    @courses = [Course.find_by_semester(Course.current_semester)]
    @requests = Request.where(:tutee_id => params[:id])
    @tutee = Tutee.find_by_id(params[:id])
  end

  def new
  end

  def edit
    @tutee = Tutee.find params[:id]
  end

  def create
    tutee_params[:email] = tutee_params[:email].downcase!
    @tutee = Tutee.new(tutee_params)
    if @tutee.save and birthdateValid? tutee_params
      flash[:message] = "Account for #{@tutee.first_name} was successfully created."
      redirect_to tutee_path(@tutee)
    else
      flash[:message] = "Invalid Inputs"
      redirect_to new_tutee_path
    end
  end

  def update
    @tutee = Tutee.find params[:id]
    tutee_params[:email] = tutee_params[:email].downcase!
    @tutee.update(tutee_params)

    if @tutee.save and birthdateValid? tutee_params
      flash[:message] = "Information was successfully updated."
      redirect_to tutee_path(@tutee)
    else
      flash[:message] = "Invalid Inputs"
      redirect_to edit_tutee_path(@tutee)
    end
  end

  def destroy
  end
end
