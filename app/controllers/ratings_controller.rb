class RatingsController < ApplicationController
  def index
    @ratings_count = Rating.count
    @users = Rails.cache.fetch(User.cache_key_collection, expires_in:10.minutes) { User.most_ratings.limit(3) }
    @recent_ratings = Rails.cache.fetch(Rating.cache_key_collection, expires_in:10.minutes) { Rating.recent.includes(:user,:beer).limit(5) }
    @breweries = Rails.cache.fetch(Brewery.cache_key_collection, expires_in:10.minutes) { Brewery.includes(:ratings).top(3) }
    @beers = Rails.cache.fetch(Beer.cache_key_collection, expires_in:10.minutes) { Beer.includes(:ratings).top(3) }
    @styles = Rails.cache.fetch(Style.cache_key_collection, expires_in:10.minutes) { Style.includes(:ratings).top(3) }
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
