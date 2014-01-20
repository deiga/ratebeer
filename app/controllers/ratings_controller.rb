class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create create_params
    redirect_to ratings_path
  end

  private

    def create_params
      params.require(:rating).permit(:score, :beer_id)
    end
end
