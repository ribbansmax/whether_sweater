class PexelsApiService
  class << self
    def picture(location)
      response = faraday.get('search') do |req|
        req.params['query'] = location
      end
      parse(response)
    end

    private
    def parse(arg)
      JSON.parse(arg.body, symbolize_names: true)
    end

    def faraday
      Faraday.new('https://api.pexels.com/v1/') do |faraday|
        faraday.headers['Authorization'] = ENV['PEXELS_API']
        faraday.params['orientation'] = 'landscape'
        faraday.params['color'] = 'orange'
      end
    end
  end
end