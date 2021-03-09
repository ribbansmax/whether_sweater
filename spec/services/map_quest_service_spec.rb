require 'rails_helper'

describe MapQuestService do
  it 'can get lat and lon' do
    VCR.use_cassette('location_denver') do
      body = MapQuestService.get_lat_lon('denver,co')
      expect(body[:results][0][:locations][0][:latLng]).to eq({ lat: 39.738453, lng: -104.984853 })
    end
  end

  it 'can get lat, lon, and travel_time' do
    VCR.use_cassette('munchies') do
      data = MapQuestService.get_destination('denver,co', 'pueblo,co')
      expect(data[:route][:formattedTime]).to eq('01:44:22')
      expect(data[:route][:locations].last[:latLng][:lat]).to eq(38.265425)
      expect(data[:route][:locations].last[:latLng][:lng]).to eq(-104.610415)
    end
  end
end
