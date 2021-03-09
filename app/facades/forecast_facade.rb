class ForecastFacade
  class << self
    def get_forecast(location)
      forecast = OpenWeatherApiService.forecast(location)
      forecast = Forecast.new(forecast)
    end

    def get_future_forecast(location)
      forecast = OpenWeatherApiService.forecast(location)
      fforecast = FutureForecast.new(forecast, location.travel_time.to_i)
    end
  end
end