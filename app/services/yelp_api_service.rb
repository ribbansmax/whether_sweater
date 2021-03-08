class YelpApiService
  class << self
    def get_restaurant(location, food)
      response = faraday.get('search') do |req|
        req.params['latitude'] = location.lat
        req.params['longitude'] = location.lon
        req.params['term'] = food
        req.params['open_at'] = unix_time(location.travel_time)
      end
      parse(response)
    end

    private

    def unix_time(time)
      # change this depending where you are going
      Time.now.utc.to_i - "07:00:00".to_time.to_i + time.to_time.to_i
    end

    def parse(arg)
      JSON.parse(arg.body, symbolize_names: true)
    end

    def faraday
      Faraday.new('https://api.yelp.com/v3/businesses/') do |faraday|
        faraday.headers['Authorization'] = ENV['YELP_API'] #note- has 'bearer' in the env
      end
    end
  end
end