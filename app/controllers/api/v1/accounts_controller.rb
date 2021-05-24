module Api 
  module V1
    class AccountsController < ApplicationController
      
      skip_before_action :verify_authenticity_token
      # GET /accounts or /accounts.json
      def index
        render json: Account.all, status: :ok
      end

      # GET /accounts/1 or /accounts/1.json
      def show
        @account = Account.find_by(id: params[:id])
        if (@account!=nil)
          render json: @account, status: :ok
        else
          render json: :nothing, status: :not_found
        end
      end

      # POST /accounts or /accounts.json
      def create
        @account = Account.new(account_params)
        
        if @account.save
          render json: @account, status: :created
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /accounts/1 or /accounts/1.json
      def update
        @account = Account.find(params[:id])
  
        if @account.update(account_params)
          render json: @account, status: :ok
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end

      # DELETE /accounts/1 or /accounts/1.json
      def destroy
        @account = Account.find(params[:id])
        if @account.destroy
          render json: :nothing, status: :ok
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