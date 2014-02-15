class Geocoding
  def self.coordinates_by_street(address)
    result = Geocoder.search(address)
    result[0].data['geometry']['location']
  end
end
