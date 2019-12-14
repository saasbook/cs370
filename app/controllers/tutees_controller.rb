class TuteesController < ApplicationController
  layout 'tutee_layout', :only => [:show, :edit]
  # Authorization section
  before_action :check_tutee_logged_in, except: [:index, :login, :createTuteeSession, :new, :create]




  def index
  end

  def show
    # puts 'SHOW '
    # puts 'params:'
    # puts params
    @courses = [Course.find_by_semester(Course.current_semester)]
    @tutee = Tutee.find_by_id(params[:id])
    @requests = @tutee.requests.where('created_at >= ?', Date.today.beginning_of_week.strftime("%Y-%m-%d"))
    @evaluations = @tutee.evaluations
    @meeting = Meeting.where(request_id: @requests).last
    if not @meeting.nil?
      @lastEval = Evaluation.find_by_id( @meeting.evaluation_id)
      if @lastEval.status == "Complete"
        @meeting = nil
        return
      end
    end
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

end
