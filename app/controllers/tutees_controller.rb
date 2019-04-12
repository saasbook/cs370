class TuteesController < ApplicationController

  def index
  end

  def show
    @courses = Course.where(:semester => Course.current_semester)

    # @courses = Course.find_by_semester(Course.current_semester).pluck(:name, :semester)
    @tutee = Tutee.find_by_id(params[:id])



  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end