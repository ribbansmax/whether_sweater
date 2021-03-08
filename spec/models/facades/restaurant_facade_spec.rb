require 'rails_helper'

describe 'RestaurantFacade' do
  it 'returns a restaurant object' do
    VCR.use_cassette("restaurant_facade") do
      destination = MapQuestFacade.get_destination('denver,co', 'pueblo,co')
      food = 'hamburger'

      restaurant = RestaurantFacade.get_restaurant(destination, food)

      stub_time = '2021-03-08 12:26:53 -0500'.to_time
      allow(Time).to receive(:now).and_return(stub_time)

      binding.pry
    end
  end
end