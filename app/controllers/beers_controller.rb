class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :set_form, only: [:new, :edit, :create]
  before_action :ensure_that_signed_in, except: [:index, :show, :list, :nglist]
  before_action :skip_if_cached, only:[:index]

  # GET /beers
  # GET /beers.json
  def index
    @beers =  case @order
              when 'name' then Beer.includes(:brewery,:style).order(:name)
              when 'brewery' then Beer.includes(:brewery,:style).order('breweries.name')
              when 'style' then Beer.includes(:brewery,:style).order('styles.name')
              end
  end

  # GET /beers/1
  # GET /beers/1.json
  def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  # GET /beers/new
  def new
    @beer = Beer.new
  end

  # GET /beers/1/edit
  def edit
  end

  # POST /beers
  # POST /beers.json
  def create
    @beer = Beer.new(beer_params)
    shared_create(@beer, beers_path)
  end

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    shared_update(@beer, beer_params)
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    @beer.destroy
    respond_to do |format|
      format.html { redirect_to beers_url }
      format.json { head :no_content }
    end
  end

  def list
  end

  def nglist
  end

  private

    def skip_if_cached
      @order = params[:order] || 'name'
      return render :index if fragment_exist?([Beer.cache_key_collection, @order])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style_id, :brewery_id)
    end

    def set_form
      @breweries = Brewery.all
      @styles = Style.all
    end
end
