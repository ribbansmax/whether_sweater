class MapQuestFacade
  class << self
    def get_lat_lon(location)
      location = MapQuestService.get_lat_lon(location)
      Location.new(location)
    end

    def get_destination(start, end_location)
      destination = MapQuestService.get_destination(start, end_location)
      destination = Destination.new(destination)
    end
  end
end