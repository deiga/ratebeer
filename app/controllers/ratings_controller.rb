class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @users = User.most_ratings.limit(3)
    @recent_ratings = Rating.recent.limit(5)
    @breweries = Brewery.top(3)
    @beers = Beer.top(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new create_params

    if current_user.nil?
      redirect_to signin_path, notice: 'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

  private

    def create_params
      params.require(:rating).permit(:score, :beer_id)
    end
end
