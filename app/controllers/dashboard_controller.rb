class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @accounts = current_user.accounts.all
  end
end
