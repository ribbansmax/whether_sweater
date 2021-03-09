class Roadtrip
  attr_reader :id, :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(cities, destination, forecast)
    @id = nil
    @start_city = case_fix(cities[:origin])
    @end_city = case_fix(cities[:destination])
    @travel_time = readable_time(destination.travel_time)
    @weather_at_eta = forecast.weather_at_eta
  end

  private

  def case_fix(location)
    location = location.split(',')
    "#{location[0].capitalize}, #{location[1].upcase}"
  end

  def readable_time(time)
    time = time.split(':')
    "#{time[0].to_i} hours #{time[1].to_i} min"
  end
end