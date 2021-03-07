class MapQuestFacade
  class << self
    def get_lat_lon(location)
      location = MapQuestService.get_lat_lon(location)
      Location.new(location)
    end
  end
end