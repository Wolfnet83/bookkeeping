class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(permitted_params)
      redirect_to current_user, notice: "User updated successfully"
    else
      flash[:error] = "User doesn't updated"
      render "show"
    end
  end

  private
  def permitted_params
      params[:user].permit(:email, :password, :password_confirmation)
  end
end
