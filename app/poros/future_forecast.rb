class FutureForecast
  attr_reader :id, :weather_at_eta

  def initialize(data, hour)
    @id = nil
    @weather_at_eta = find_weather(data, hour)
  end

  private

  def find_weather(data, hour)
    if hour <= 47
      {
        temperature: data[:hourly][hour][:temp],
        conditions: data[:hourly][hour][:weather].first[:description]
      }
    elsif hour <= 119
      day = hour / 24
      {
        temperature: data[:daily][day][:temp][:day],
        conditions: data[:daily][day][:weather].first[:description]
      }
    else
      {
        temperature: 'nobody knows',
        conditions: 'unclear, or maybe clear, too far out to tell'
      }
    end
  end
end
