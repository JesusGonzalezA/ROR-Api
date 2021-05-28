module Api 
  module V1
    class AccountsController < ApplicationController
      
      skip_before_action :verify_authenticity_token
      # GET /accounts or /accounts.json
      def index
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          accounts = Account.where(user_id: user["id"])
          render json: accounts, status: :ok
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      # GET /accounts/1 or /accounts/1.json
      def show
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          account = Account.find_by(id: params[:id], user_id: user["id"])
          if ( account != nil )
            render json: account, status: :ok
          else
            render json: :nothing, status: :unprocessable_entity
          end
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      # POST /accounts or /accounts.json
      def create
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)

        if ( user )
          user_id = user["id"]
          balance = account_params["balance"] 
          account = Account.new(user_id: user_id, balance: balance)

          if account.save
            render json: account, status: :created
          else
            render json: account.errors, status: :unprocessable_entity
          end
        else
          render json: :nothing, status: :unprocessable_entity
        end
        
      end

      # PATCH/PUT /accounts/1 or /accounts/1.json
      def update
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          account = Account.find_by(user_id: user["id"], id: params[:id])
          
          if ( account == nil )
            render json: :nothing, status: :unprocessable_entity
            return
          end

          if account.update(account_params)
            render json: account, status: :ok
          else
            render json: account.errors, status: :unprocessable_entity
          end
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      # DELETE /accounts/1 or /accounts/1.json
      def destroy
        email = AuthenticationHelper::Auth.instance.getEmailFromJWT( request )
        if ( email == nil )
          render json: :nothing, status: :unprocessable_entity
          return
        end

        user = User.find_by(email: email)
        if ( user )
          account = Account.find_by(user_id: user["id"], id: params[:id])
          
          if ( account == nil )
            render json: :nothing, status: :unprocessable_entity
            return
          end


          if account.destroy
            render json: :nothing, status: :ok
          else
            render json: :nothing, status: :unprocessable_entity
          end
        else
          render json: :nothing, status: :unprocessable_entity
        end
      end

      private
        # Only allow a list of trusted parameters through.
        def account_params
          params.require(:account).permit(:balance, :user_id)
        end
    end
  end
end