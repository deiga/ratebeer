class BeermappingApi
  def self.places_in(city)
    response = HTTParty.get "#{url}#{CGI::escape(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.key
    'f47685755b310c3061c86c7417d92d65'
  end

  def self.url
    "http://beermapping.com/webservice/loccity/#{key}/"
  end
end
