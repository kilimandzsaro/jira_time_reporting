class ComponenetsController < ApplicationController
  before_action :set_componenet, only: [:show, :edit, :update, :destroy]

  # GET /componenets
  # GET /componenets.json
  def index
    @componenets = Componenet.all
  end

  # GET /componenets/1
  # GET /componenets/1.json
  def show
  end

  # GET /componenets/new
  def new
    @componenet = Componenet.new
  end

  # GET /componenets/1/edit
  def edit
  end

  # POST /componenets
  # POST /componenets.json
  def create
    @componenet = Componenet.new(componenet_params)

    respond_to do |format|
      if @componenet.save
        format.html { redirect_to @componenet, notice: 'Componenet was successfully created.' }
        format.json { render :show, status: :created, location: @componenet }
      else
        format.html { render :new }
        format.json { render json: @componenet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /componenets/1
  # PATCH/PUT /componenets/1.json
  def update
    respond_to do |format|
      if @componenet.update(componenet_params)
        format.html { redirect_to @componenet, notice: 'Componenet was successfully updated.' }
        format.json { render :show, status: :ok, location: @componenet }
      else
        format.html { render :edit }
        format.json { render json: @componenet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /componenets/1
  # DELETE /componenets/1.json
  def destroy
    @componenet.destroy
    respond_to do |format|
      format.html { redirect_to componenets_url, notice: 'Componenet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_componenet
      @componenet = Componenet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def componenet_params
      params.require(:componenet).permit(:name)
    end
end
