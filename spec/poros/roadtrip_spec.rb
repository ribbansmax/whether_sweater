require 'rails_helper'

describe Roadtrip do
  it 'has attributes' do
    weather = {
      temperature: -6,
      conditions: 'beautiful, but very cold'
    }

    mock = double('mock')
    allow(mock).to receive(:travel_time).and_return('03:56:00')
    fmock = double('fmock')
    allow(fmock).to receive(:weather_at_eta).and_return(weather)

    cities = {
      origin: 'providence,ri',
      destination: 'burlington,vt'
    }

    roadtrip = Roadtrip.new(cities, mock, fmock)

    expect(roadtrip.id).to eq(nil)
    expect(roadtrip.start_city).to eq('Providence, RI')
    expect(roadtrip.end_city).to eq('Burlington, VT')
    expect(roadtrip.travel_time).to eq("3 hours 56 min")
    expect(roadtrip.weather_at_eta).to eq(weather)
  end
end