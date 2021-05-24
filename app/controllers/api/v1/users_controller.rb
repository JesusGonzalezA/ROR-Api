module Api 
  module V1
    class UsersController < ApplicationController

      skip_before_action :verify_authenticity_token
      # GET /users or /users.json
      def index
        render json: User.all, status: :ok
      end

      # GET /users/1 or /users/1.json
      def show
        @user = User.find_by(id: params[:id])
        if (@user!=nil)
          render json: @user, status: :ok
        else
          render json: :nothing, status: :not_found
        end
      end

      # POST /users or /users.json
      def create
        user = User.new(user_params)
        
        if user.save
          render json: user, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1 or /users/1.json
      def update
        user = User.find(params[:id])
  
        if user.update(user_params)
          render json: user, status: :ok
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1 or /users/1.json
      def destroy
        user = User.find(params[:id])
        if user.destroy
          render json: :nothing, status: :ok
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      private
        # Only allow a list of trusted parameters through.
        def user_params
          params.require(:user).permit(:email, :password)
        end
    end
  end
end
