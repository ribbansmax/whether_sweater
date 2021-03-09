require 'rails_helper'

describe 'Munchies route' do
  it 'gets a destination city, travel time, name and address of restaurant serving the cuisine, that will be open.' do
    VCR.use_cassette('munchies_and_weather_and_yelp') do
      stub_time = '2021-03-08 12:26:53 -0500'.to_time
      allow(Time).to receive(:now).and_return(stub_time)
      get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data.keys).to eq(%i[id type attributes])
      expect(data[:attributes].keys).to eq(%i[destination_city travel_time forecast restaurant])
      expect(data[:attributes][:destination_city]).to eq('Pueblo, CO')
      expect(data[:attributes][:travel_time]).to eq('1 hours 44 min')
      expect(data[:attributes][:forecast]).to eq({ summary: 'clear sky', temperature: 57 })
      expect(data[:attributes][:restaurant]).to eq({ name: "Carl's Jr",
                                                     address: '102 S Santa Fe Ave, Pueblo, CO 81003' })
    end
  end
  describe 'sad paths to m̶a̶k̶e̶ ̶s̶u̶r̶e̶ ensure I pass' do
    it 'should return mapquest error' do
      VCR.use_cassette('map_error') do
        stub_time = '2021-03-08 12:26:53 -0500'.to_time
        allow(Time).to receive(:now).and_return(stub_time)
        get '/api/v1/munchies?start=kjsadhkljhsakljasd,sksk,asad&destination=pueblo,co&food=hamburger'

        expect(response.status).to eq(400)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('route error')
      end
    end
    it 'should return route error for no start' do
      VCR.use_cassette('no_start_error') do
        stub_time = '2021-03-08 12:26:53 -0500'.to_time
        allow(Time).to receive(:now).and_return(stub_time)
        get '/api/v1/munchies?destination=denver,co&food=hamburger'

        expect(response.status).to eq(400)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('route error')
      end
    end
    it 'should return yelp error' do
      VCR.use_cassette('yelp_error') do
        stub_time = '2021-03-08 12:26:53 -0500'.to_time
        allow(Time).to receive(:now).and_return(stub_time)
        get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=boogilyboogilyboonofoodforyou'

        expect(response.status).to eq(404)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('yelp error, no restaurant found')
      end
    end
    it 'should return weather error' do
      VCR.use_cassette('weather_error') do
        stub_time = '2021-03-08 12:26:53 -0500'.to_time
        allow(Time).to receive(:now).and_return(stub_time)
        allow(OpenWeatherApiService).to receive(:forecast).and_return(nil)
        get '/api/v1/munchies?start=denver,co&destination=pueblo,co&food=hamburger'

        expect(response.status).to eq(404)
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('forecast error')
      end
    end
  end
end
