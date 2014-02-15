class PlacesController < ApplicationController
  def index
  end

  def search
    api_key = 'f47685755b310c3061c86c7417d92d65'
    url = 'http://stark-oasis-9187.herokuapp.com/api/'
    response = HTTParty.get "#{url}#{CGI::escape(params[:city])}"

    places = response.parsed_response["bmp_locations"]["location"]

    if places.is_a?(Hash) and places['id'].nil?
      redirect_to places_path, :notice => "No places in #{params[:city]}"
    else
      places = [places] if places.is_a?(Hash)
      @places = places.inject([]) do | set, location|
        set << Place.new(location)
      end
      render :index
    end

  end
end
