module Api
  module V1
    class AuthenticationController < ApplicationController
      skip_before_action :verify_authenticity_token

      def get_token
        user = User.find_for_database_authentication(email: params[:email])
        if user && user.valid_password?(params[:password])
          render json: payload(user)
        else
          render json: { message: 'Invalid Username/Password' }, status: :unauthorized
        end
      end

      private

      def payload(user)
        return nil unless user and user.id
        {
          auth_token: JsonWebToken.encode({user_id: user.id}),
          user: {id: user.id, email: user.email}
        }
      end
    end
  end
end