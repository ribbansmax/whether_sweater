class ForecastFacade
  class << self
    def get_forecast(location)
      forecast = OpenWeatherApiService.forecast(location)
      forecast = Forecast.new(forecast)
    end
  end
end