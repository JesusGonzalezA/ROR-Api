module Api 
  module V1
    class MovementsController < ApplicationController
      
      skip_before_action :verify_authenticity_token
      # GET /movements or /movements.json
      def index
        render json: Movement.all, status: :ok
      end

      # GET /movements/1 or /movements/1.json
      def show
        @movement = Movement.find_by(id: params[:id])
        if (@movement!=nil)
          render json: @movement, status: :ok
        else
          render json: :nothing, status: :not_found
        end
      end

      # POST /movements or /movements.json
      def create
        @movement = Movement.new(movement_params)
        
        if @movement.save
          render json: @movement, status: :created
        else
          render json: @movement.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /movements/1 or /movements/1.json
      def update
        @movement = Movement.find(params[:id])
  
        if @movement.update(movement_params)
          render json: @movement, status: :ok
        else
          render json: @movement.errors, status: :unprocessable_entity
        end
      end

      # DELETE /movements/1 or /movements/1.json
      def destroy
        @movement = Movement.find(params[:id])
        if @movement.destroy
          render json: :nothing, status: :ok
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