class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find_by_id(session[:current_user_id])
    byebug
  end
end
