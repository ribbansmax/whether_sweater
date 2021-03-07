class Forecast
  attr_reader :id

  def initialize(data)
    @id = nil
    @cw = data[:current].slice(
      :dt,
      :sunrise,
      :sunset,
      :temp,
      :feels_like,
      :humidity,
      :uvi,
      :visibility,
      :weather
    )
    @dw = data[:daily].map do |day|
      day.slice(
        :dt,
        :sunrise,
        :sunset,
        :temp,
        :weather
      )
    end.first(5)
    @hw = data[:hourly].map do |hour|
      hour.slice(
        :dt,
        :temp,
        :weather
      )
    end.first(8)
  end

  def current_weather
    {
      datetime: readable(@cw[:dt]),
      sunrise: readable(@cw[:sunrise]),
      sunset: readable(@cw[:sunset]),
      temperature: @cw[:temp],
      feels_like: @cw[:feels_like],
      humidity: @cw[:humidity],
      uvi: @cw[:uvi],
      visibility: @cw[:visibility],
      conditions: @cw[:weather].first[:description],
      icon: @cw[:weather].first[:icon]
    }
  end

  def daily_weather
    @dw.map do |day|
      {
        datetime: readable(day[:dt]),
        sunrise: readable(day[:sunrise]),
        sunset: readable(day[:sunset]),
        min_temp: day[:temp][:min],
        max_temp: day[:temp][:max],
        conditions: day[:weather].first[:description],
        icon: day[:weather].first[:icon]
      }
    end
  end

  def hourly_weather
    @hw.map do |hour|
      {
        datetime: readable(hour[:dt]),
        temperature: hour[:temp],
        conditions: hour[:weather].first[:description],
        icon: hour[:weather].first[:icon]
      }
    end
  end

  private

  def readable(time)
    Time.at(time)
  end
end