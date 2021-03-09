require 'rails_helper'

describe 'MapQuestFacade' do
  it 'returns a location object' do
    VCR.use_cassette("location_denver") do
      location = MapQuestFacade.get_lat_lon('denver,co')

      expect(location.class).to eq(Location)
      expect(location.lat).to eq(39.738453)
      expect(location.lon).to eq(-104.984853)
    end
  end
end