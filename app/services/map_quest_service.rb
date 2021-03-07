class MapQuestService
  class << self
    def get_lat_lon(location)
      response = faraday.get('address') do |req|
        req.params['location'] = location
      end
      parse(response)
    end

    private
    def parse(arg)
      JSON.parse(arg.body, symbolize_names: true)
    end

    def faraday
      Faraday.new('http://www.mapquestapi.com/geocoding/v1/') do |faraday|
        faraday.params['key'] = ENV['MAP_QUEST_API']
      end
    end
  end
end