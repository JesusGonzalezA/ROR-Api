module Api 
  module V1
    class UsuariosController < ApplicationController
        
        skip_before_action :verify_authenticity_token
        # GET /usuarios or /usuarios.json
        def index
          render json: Usuario.all, status: :ok
        end
      
        # GET /usuarios/1 or /usuarios/1.json
        def show
          @usuario = Usuario.find_by(id: params[:id])
          if (@usuario!=nil)
            render json: @usuario, status: :ok
          else
           render json: :nothing, status: :not_found
          end
        end
      
        # POST /usuarios or /usuarios.json
        def create
          @usuario = Usuario.new(usuario_params)
      
            if @usuario.save
              render json: @usuario, status: :created
            else
              render json: @usuario.errors, status: :unprocessable_entity
            end
        end
      
        # PATCH/PUT /usuarios/1 or /usuarios/1.json
        def update
          @usuario = Usuario.find(params[:id])

            if @usuario.update(usuario_params)
              render json: @usuario, status: :ok
            else
              render json: @usuario.errors, status: :unprocessable_entity
            end
        end
      
        # DELETE /usuarios/1 or /usuarios/1.json
        def destroy
          @usuario = Usuario.find(params[:id])
          if @usuario.destroy
            render json: :nothing, status: :ok
          else
            render json: :nothing, status: :unprocessable_entity
          end
        end
      
        private
          # Only allow a list of trusted parameters through.
          def usuario_params
            params.require(:usuario).permit(:email, :password)
          end
    end
  end
end