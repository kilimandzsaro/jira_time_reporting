class BusinessesController < ApplicationController
  before_action :set_business, only: [:edit, :update]

  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
  end

  def new(business)
    # business = Business.new(XX,YYY)
    @business = business
  end

  # GET /businesses/1/edit
  def edit
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    respond_to do |format|
      if @business.update(business_params)
        format.html { redirect_to businesses_path, notice: 'Business was successfully updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :price)
    end
end
