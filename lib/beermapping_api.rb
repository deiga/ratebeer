class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week.from_now) { fetch_places_in(city) }
  end

  def self.place(id)
    Rails.cache.fetch(id, expires_in: 2.weeks.from_now) { fetch_place(id) }
  end

  private

    def self.fetch_places_in(city)
      url = Figaro.env.beermapping_city_url % {key: key}
      response = HTTParty.get "#{url}#{CGI::escape(city)}"
      places = response.parsed_response["bmp_locations"]["location"]

      return [] if places.is_a?(Hash) and places['id'].nil?

      places = [places] if places.is_a?(Hash)
      places.inject([]) do | set, place |
        set << Place.new(place)
      end
    end

    def self.key
      Figaro.env.beermapping_api_key
    end

    def self.fetch_place(id)
      url = Figaro.env.beermapping_query_url % {key: key}
      response = response = HTTParty.get "#{url}#{id}"

      place = response.parsed_response["bmp_locations"]["location"]
      Place.new(place)
    end
end
