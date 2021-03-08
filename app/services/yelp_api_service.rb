class YelpApiService
  class << self
    def get_restaurant(location, food)
      response = faraday.get('search') do |req|
        req.params['latitude'] = location.lat
        req.params['longitude'] = location.lon
        req.params['term'] = food
      end
      parse(response)
    end

    private
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