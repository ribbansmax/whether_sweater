class Munchie
  attr_reader :id, :destination_city, :travel_time, :forecast, :restaurant

  def initialize(destination, weather, restaurant, location)
    @id = nil
    @destination_city = case_fix(location)
    @travel_time = readable_time(destination.travel_time)
    @forecast = convert_forecast(weather)
    @restaurant = {
      name: restaurant.name,
      address: restaurant.address
    }
  end

  private

  def case_fix(location)
    location = location.split(',')
    "#{location[0].capitalize}, #{location[1].upcase}"
  end

  def convert_forecast(weather)
    cw = weather.current_weather
    {
      summary: cw[:conditions],
      temperature: cw[:temperature].round(0)
    }
  end

  def readable_time(time)
    time = time.split(':')
    "#{time[0].to_i} hours #{time[1].to_i} min"
  end
end