class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.minute.from_now) { fetch_places_in(city) }
  end

  private

    def self.fetch_places_in(city)
    response = HTTParty.get "#{url}#{CGI::escape(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

    def self.key
      Figaro.env.beermapping_apikey
    end

    def self.url
      Figaro.env.beermapping_url % {key: key}
    end
end
