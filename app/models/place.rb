class Place
  include ActiveModel::Model

  attr_accessor :id, :name, :status, :reviewlink, :proxylink, :blogmap, :street, :city, :state, :zip, :country, :phone, :overall, :imagecount

  def self.rendered_fields
    [:id, :name, :status, :street, :city, :zip, :country, :overall]
  end

  def coordinates
    Rails.cache.fetch([self, 'coords'], expires_in: 2.weeks.from_now) { Geocoding.coordinates_by_street(address) }
  end

  def lat
    coordinates['lat']
  end

  def lon
    coordinates['lng']
  end

  def address
    [street, city, country].compact.join(',')
  end
end
