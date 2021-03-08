class Destination
  attr_reader :travel_time, :lat, :lon

  def initialize(data)
    @travel_time = data[:route][:formattedTime]
    @lat = data[:route][:locations].last[:latLng][:lat]
    @lon = data[:route][:locations].last[:latLng][:lng]
  end
end