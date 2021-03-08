require 'rails_helper'

describe "Munchies route" do
  it "gets a destination city, travel time, name and address of restaurant serving the cuisine, that will be open." do
    VCR.use_cassette("munchies_and_weather_and_yelp") do
      stub_time = '2021-03-08 12:26:53 -0500'.to_time
      allow(Time).to receive(:now).and_return(stub_time)
      get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'

      expect(response).to be_successful
    end
  end
end