require 'rails_helper'

describe Location do
  it 'has attributes' do
    body = {results: [locations: [latLng: {:lat=>39.738453, :lng=>-104.984853}]]}
    location = Location.new(body)

    expect(location.lat).to eq(39.738453)
    expect(location.lon).to eq(-104.984853)
  end
end