module Api
  module V1
    class CurrenciesController < ApplicationController

      before_action :authenticate_user!
      respond_to :json

      def index
        respond_with current_user.currency.all
      end
    end
  end
end