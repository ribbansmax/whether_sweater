require 'rails_helper'

describe "Forecast API" do
  it "sends a forecast" do
    VCR.use_cassette("location_denver_both_calls") do
      get "/api/v1/forecast?location=denver,co"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data.keys).to eq([:id, :type, :attributes])
      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq('forecast')
      expect(data[:attributes].keys).to eq([:current_weather, :daily_weather, :hourly_weather])
      expect(data[:attributes][:current_weather].keys).to eq([:datetime, :sunrise, :sunset, :temperature, :feels_like, :humidity, :uvi, :visibility, :conditions, :icon])
      expect(data[:attributes][:daily_weather].length).to eq(5)
      data[:attributes][:daily_weather].each do |day|
        expect(day.keys).to eq([:datetime, :sunrise, :sunset, :min_temp, :max_temp, :conditions, :icon])
      end
      expect(data[:attributes][:hourly_weather].length).to eq(8)
      data[:attributes][:hourly_weather].each do |hour|
        expect(hour.keys).to eq([:datetime, :temperature, :conditions, :icon])
      end
    end
  end

  it 'sad path, invalid location' do
    VCR.use_cassette("bad_location") do
      get '/api/v1/forecast?location=aksjdjjsklakjdfsaf,sjjgfddsjeeeeeeak'

      expect(response.status).to eq(404)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('bad location')
    end
  end

  it 'sad path, no location' do
    VCR.use_cassette("no_location") do
      get '/api/v1/forecast?location='

      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('no location given')
    end
  end

  it 'sad path, open weather is down' do
    VCR.use_cassette('weather_down') do
      get "/api/v1/forecast?location=denver,co"

      expect(response.status).to eq(400)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('open-weather is down')
    end
  end
end