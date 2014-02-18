class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy, :toggle_activity]
  before_action :ensure_that_signed_in, except: [:index, :show]

  # GET /breweries
  # GET /breweries.json
  def index
    order = params[:order] || 'name'

    @active_breweries = Brewery.active.order(order)
    @retired_breweries = Brewery.retired.order(order)
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)
    shared_create(@brewery, breweries_path)
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    shared_update(@brewery, brewery_params)
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  def list
  end

  def toggle_activity
    @brewery.update_attribute :active, (not @brewery.active)

    new_status = @brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
end
