require 'rails_helper'

describe 'MapQuestFacade' do
  it 'returns a location object' do
    VCR.use_cassette('location_denver') do
      location = MapQuestFacade.get_lat_lon('denver,co')

      expect(location.class).to eq(Location)
      expect(location.lat).to eq(39.738453)
      expect(location.lon).to eq(-104.984853)
    end
  end

  it 'returns a destination object' do
    VCR.use_cassette('munchies') do
      destination = MapQuestFacade.get_destination('denver,co', 'pueblo,co')

      expect(destination.class).to eq(Destination)
      expect(destination.lat).to eq(38.265425)
      expect(destination.lon).to eq(-104.610415)
      expect(destination.travel_time).to eq('01:44:22')
    end
  end
end
