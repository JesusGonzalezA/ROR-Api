module Api 
    module V1
      class CuentaController < ApplicationController
          
          skip_before_action :verify_authenticity_token
          # GET /cuentas or /cuentas.json
          def index
            render json: Cuentum.all, status: :ok
          end
        
          # GET /cuentas/1 or /cuentas/1.json
          def show
            @cuentum = Cuentum.find_by(id: params[:id])
            if (@cuentum!=nil)
              render json: @cuentum, status: :ok
            else
             render json: :nothing, status: :not_found
            end
          end
        
          # POST /cuentas or /cuentas.json
          def create
            @cuentum = Cuentum.new(cuentum_params)
        
              if @cuentum.save
                render json: @cuentum, status: :created
              else
                render json: @cuentum.errors, status: :unprocessable_entity
              end
          end
        
          # PATCH/PUT /cuentas/1 or /cuentas/1.json
          def update
            @cuentum = Cuentum.find(params[:id])
  
              if @cuentum.update(cuentum_params)
                render json: @cuentum, status: :ok
              else
                render json: @cuentum.errors, status: :unprocessable_entity
              end
          end
        
          # DELETE /cuentas/1 or /cuentas/1.json
          def destroy
            @cuentum = Cuentum.find(params[:id])
            if @cuentum.destroy
              render json: :nothing, status: :ok
            else
              render json: :nothing, status: :unprocessable_entity
            end
          end
        
          private
            # Only allow a list of trusted parameters through.
            def cuentum_params
                params.require(:cuentum).permit(:saldo, :usuario_id)
            end
      end
    end
  end