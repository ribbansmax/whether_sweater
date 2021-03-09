class FutureForecast
  attr_reader :id, :weather_at_eta

  def initialize(data, hour)
    @id = nil
    @weather_at_eta = {
      temperature: data[:hourly][hour][:temp],
      conditions: data[:hourly][hour][:weather].first[:description]
    }
  end
end