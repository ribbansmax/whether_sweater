module ForecastHelper
  def current_weather(forecast)
    forecast.current_weather
  end

  def daily_weather(forecast)
    forecast.daily_weather
  end

  def hourly_weather(forecast)
    forecast.hourly_weather
  end
end

class ForecastSerializer
  include FastJsonapi::ObjectSerializer

  extend ForecastHelper

  attribute :current_weather do |forecast|
    current_weather(forecast)
  end
  attribute :daily_weather do |forecast|
    daily_weather(forecast)
  end
  attribute :hourly_weather do |forecast|
    hourly_weather(forecast)
  end
end
