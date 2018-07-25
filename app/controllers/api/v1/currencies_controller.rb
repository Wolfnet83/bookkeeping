module Api
  module V1
    class CurrenciesController < ApplicationController

      before_action :authenticate_request!
      respond_to :json

      def index
        respond_with Currency.all
      end
    end
  end
end