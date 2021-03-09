require 'rails_helper'

describe MapQuestService do
  it 'can get lat and lon' do
    VCR.use_cassette("location_denver") do
      body = MapQuestService.get_lat_lon('denver,co')
      expect(body[:results][0][:locations][0][:latLng]).to eq({:lat=>39.738453, :lng=>-104.984853})
    end
  end
end