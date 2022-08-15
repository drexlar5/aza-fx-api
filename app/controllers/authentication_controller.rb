class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def register
        command = RegisterUser.call(params[:email], params[:password])

        if command.success?
            render json: { user: command.result }
        else
            render json: { error: command.errors }, status: :bad_request
        end
    end
   
    def authenticate
      command = AuthenticateUser.call(params[:email], params[:password])
   
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
end