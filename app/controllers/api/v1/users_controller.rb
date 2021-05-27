require 'json'

module Api 
  module V1
    class UsersController < ApplicationController

      skip_before_action :verify_authenticity_token
      # GET /users or /users.json
      def index  
        isPasswordCorrect = AuthenticationHelper::Auth.instance.checkPassword( request.body )
        params      = JSON.parse( request.body.read )
        emailParams = params["email"]
       
        if ( isPasswordCorrect )
          token = AuthenticationHelper::Auth.instance.generateJWT( emailParams )
          render json: token, status: :ok
        else 
          render json: :nothing, status: :not_found
        end
      end

      # POST /users or /users.json
      def create
        user   = User.new(user_params)
        userDB = User.find_by(email: user_params["email"])
        
        if ( userDB == nil )
          if user.save
            token = AuthenticationHelper::Auth.instance.generateJWT( user_params["email"] )
            render json: token, status: :created
          else
            render json: user.errors, status: :unprocessable_entity
          end
        else
          render json: :nothing, status: :unprocessable_entity 
        end
      end

      # PATCH/PUT /users/id /users/id
      def update
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)


        if ( user_params["email"] != nil )
          email = user_params["email"]
          userDB = User.find_by(email: email)
          
          if ( userDB != nil )
            render json: :nothing, status: :unprocessable_entity
            return
          end
        end
        
        if user.update(user_params)
          token = AuthenticationHelper::Auth.instance.generateJWT( email )
          render json: token, status: :ok
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      # DELETE /users/1 or /users/1.json
      def destroy
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
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
