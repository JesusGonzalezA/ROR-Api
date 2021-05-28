module Api 
  module V1
    class MovementsController < ApplicationController
      
      skip_before_action :verify_authenticity_token
      # GET /movements or /movements.json
      def index
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          accounts  = Account.where(user_id: user["id"])
          movements = Movement.where(:account_id => accounts)
          render json: movements, status: :ok
        else
          render json: :nothing, status: :unprocessable_entity
        end
        
      end

      # GET /movements/1 or /movements/1.json
      def show
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          accounts  = Account.where(user_id: user["id"])
          movement = Movement.find_by(:account_id => accounts, id: params[:id])

          if (movement==nil)
            render json: :nothing, status: :not_found
          else 
            render json: movement, status: :ok
          end
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      # POST /movements or /movements.json
      def create
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)

        if ( user )
          accounts = Account.select(:id).where(user_id: user["id"])
          found = false
          accounts.each do |account|
            found = account["id"] == movement_params["account_id"]
            if (found)
              break
            end
          end

          if ( found == false )
            render json: :nothing, status: :unprocessable_entity
          else
            movement = Movement.new(movement_params)
            if movement.save
              render json: movement, status: :created
            else
              render json: movement.errors, status: :unprocessable_entity
            end
          end

        else 
          render json: :nothing, status: :unprocessable_entity
        end

      end

      # PATCH/PUT /movements/1 or /movements/1.json
      def update
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)

        if ( user )
          movement = Movement.find_by(id: params[:id])
          if ( !movement )
            render json: :nothing, status: :not_found
            return 
          end

          accounts = Account.select(:id).where(user_id: user["id"])
          found = false
          accounts.each do |account|
            found = account["id"] == movement["account_id"]
            if (found)
              break
            end
          end
          
          if ( found == false )
            render json: :nothing, status: :unprocessable_entity
          else           
            if movement.update(movement_params)
              render json: movement, status: :ok
            else
              render json: movement.errors, status: :unprocessable_entity
            end
          end

        else
          render json: :nothing, status: :unprocessable_entity
        end        
      end

      # DELETE /movements/1 or /movements/1.json
      def destroy
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)

        if ( user )
          movement = Movement.find_by(id: params[:id])
          if ( !movement )
            render json: :nothing, status: :not_found
            return 
          end
          
          accounts = Account.select(:id).where(user_id: user["id"])
          found = false
          accounts.each do |account|
            found = account["id"] == movement["account_id"]
            if (found)
              break
            end
          end
          
          if ( found == false )
            render json: :nothing, status: :unprocessable_entity
          else           
            movement = Movement.find(params[:id])
            if movement.destroy
              render json: :nothing, status: :ok
            else
              render json: :nothing, status: :unprocessable_entity
            end
          end

        else
          render json: :nothing, status: :unprocessable_entity
        end     
        
      end

      private
        # Only allow a list of trusted parameters through.
        def movement_params
          params.require(:movement).permit(:balance, :when, :account_id)
        end
    end
  end
end