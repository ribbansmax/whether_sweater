class MapQuestFacade
  class << self
    def get_lat_lon(location)
      location = MapQuestService.get_lat_lon(location)
      Location.new(location)
    end

    def get_destination(start, end_location)
      destination = MapQuestService.get_destination(start, end_location)
      raise 'bad mapquest' if destination[:info][:statuscode] >= 500
      raise 'impossible' if destination[:info][:statuscode] >= 400

      Destination.new(destination)
    end
  end
end
