module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorized, only: [:auto_login]

      def create
        @user = User.create(user_params)
        if @user.valid?
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { errors: "Invalid username or password" }
        end
      end

      def login
        @user = User.find_by(user_name: params[:user][:user_name])

        if @user && @user.authenticate(params[:user][:password])
          token = encode_token({ user_id: @user.id })
          render json: { user: @user, token: token }
        else
          render json: { errors: "Invalid username or password" }
        end
      end

      def auto_login
        render json: @user
      end

      private

      def user_params
        params.require(:user).permit(:user_name, :email, :password)
      end

    end
  end
end