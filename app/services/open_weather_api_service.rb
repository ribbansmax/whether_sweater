class OpenWeatherApiService
  class << self
    def forecast(location)
      response = faraday.get('onecall') do |req|
        req.params['lon'] = location.lon
        req.params['lat'] = location.lat
      end
      parse(response)
    end

    private
    def parse(arg)
      JSON.parse(arg.body, symbolize_names: true)
    end

    def faraday
      Faraday.new('http://api.openweathermap.org/data/2.5/') do |faraday|
        faraday.params['appid'] = ENV['OPEN_WEATHER_API']
        faraday.params['exclude'] = 'minutely,alerts'
        faraday.params['units'] = 'imperial'
      end
    end
  end
end