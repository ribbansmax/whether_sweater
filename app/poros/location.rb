class Location
  attr_reader :lat, :lon

  def initialize(location)
    lat_lon = location[:results][0][:locations][0][:latLng]
    @lat = lat_lon[:lat]
    @lon = lat_lon[:lng]
  end
end