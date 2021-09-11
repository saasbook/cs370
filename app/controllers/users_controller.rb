class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(session[:current_user_id])

    #tutors get their own dashboard, but also an option to switch between tutee/tutor views
    if @user.type == 'Tutee'
      show_tutee_dashboard
    else
      show_tutor_dashboard
    end
  end

  private
  def show_tutee_dashboard

  end

  def show_tutor_dashboard
    @meetings = Meeting.where("tutor_id = ? AND is_done = FALSE", @user.id)
    @previous_meetings = Meeting.where("tutor_id = ? AND is_done = TRUE", @user.id)
  end
end
