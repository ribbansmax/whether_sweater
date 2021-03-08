require 'rails_helper'

describe "Munchies route" do
  it "gets a destination city, travel time, name and address of restaurant serving the cuisine, that will be open." do
    VCR.use_cassette("munchies_and_weather_and_yelp") do
      stub_time = '2021-03-08 12:26:53 -0500'.to_time
      allow(Time).to receive(:now).and_return(stub_time)
      get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data.keys).to eq([:id, :type, :attributes])
      expect(data[:attributes].keys).to eq([:destination_city, :travel_time, :forecast, :restaurant])
      expect(data[:attributes][:destination_city]).to eq('Pueblo, CO')
      expect(data[:attributes][:travel_time]).to eq("1 hours 44 min")
      expect(data[:attributes][:forecast]).to eq({:summary=>"clear sky", :temperature=>53})
      expect(data[:attributes][:restaurant]).to eq({:name=>"Carl's Jr", :address=>"102 S Santa Fe Ave, Pueblo, CO 81003"})

      binding.pry
    end
  end
end