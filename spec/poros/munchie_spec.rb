require 'rails_helper'

describe Munchie do
  it 'has attributes' do
    VCR.use_cassette('munchie_poro') do
      params = {
        start: 'champaign,il',
        destination: 'denver,co',
        food: 'fast'
      }
      stub_time = '2021-03-08 12:26:53 -0500'.to_time
      allow(Time).to receive(:now).and_return(stub_time)

      destination = MapQuestFacade.get_destination(params[:start], params[:destination])
      forecast = ForecastFacade.get_forecast(destination)
      restaurant = RestaurantFacade.get_restaurant(destination, params[:food])

      munchie = Munchie.new(destination, forecast, restaurant, params[:destination])

      expect(munchie.id).to eq(nil)
      expect(munchie.destination_city).to eq('Denver, CO')
      expect(munchie.travel_time).to eq('14 hours 19 min')
      expect(munchie.forecast).to eq({ summary: 'overcast clouds', temperature: 52 }) # nice temps there soon!
      expect(munchie.restaurant).to eq({ name: 'Gyroz', address: '880 E Colfax Ave, Denver, CO 80218' })
    end
  end
end
