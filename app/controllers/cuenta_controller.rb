class CuentaController < ApplicationController
  before_action :set_cuentum, only: %i[ show edit update destroy ]

  # GET /cuenta or /cuenta.json
  def index
    @cuenta = Cuentum.all
  end

  # GET /cuenta/1 or /cuenta/1.json
  def show
  end

  # GET /cuenta/new
  def new
    @cuentum = Cuentum.new
  end

  # GET /cuenta/1/edit
  def edit
  end

  # POST /cuenta or /cuenta.json
  def create
    @cuentum = Cuentum.new(cuentum_params)

    respond_to do |format|
      if @cuentum.save
        format.html { redirect_to @cuentum, notice: "Cuentum was successfully created." }
        format.json { render :show, status: :created, location: @cuentum }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cuentum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cuenta/1 or /cuenta/1.json
  def update
    respond_to do |format|
      if @cuentum.update(cuentum_params)
        format.html { redirect_to @cuentum, notice: "Cuentum was successfully updated." }
        format.json { render :show, status: :ok, location: @cuentum }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cuentum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cuenta/1 or /cuenta/1.json
  def destroy
    @cuentum.destroy
    respond_to do |format|
      format.html { redirect_to cuenta_url, notice: "Cuentum was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cuentum
      @cuentum = Cuentum.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cuentum_params
      params.require(:cuentum).permit(:saldo, :usuario_id)
    end
end
