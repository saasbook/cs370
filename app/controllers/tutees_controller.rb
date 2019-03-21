class TuteesController < ApplicationController

  def tutee_params
    params.require(:tutee).permit(:first_name, :last_name, :sid, :priviledge, :email)
  end

  def index

  end

  def show
  end

  def new
    # default: render 'new' template if they have not logged in before
  end

  def edit
    @tutee = Tutee.find params[:id]
  end

  def create
    @tutee = Tutee.create!(tutee_params)
    flash[:notice] = "Account for #{@tutee.first_name} was successfully created."
    redirect_to tutees_path
  end

  def update
    @tutee = Tutee.find params[:id]
    @tutee.update_attributes!(tutee_params)
    flash[:notice] = "information was successfully updated."
    redirect_to tutees_path
  end

  def destroy
  end
end
