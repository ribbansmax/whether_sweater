require 'rails_helper'

describe "Makes a road trip" do
  describe "happy path" do
    it "should sign in a user" do
      VCR.use_cassette('roadtrip_to_pueblo') do
        data = {
          email: 'email@example.com',
          password: 'Password',
          password_confirmation: 'Password'
        }

        user = User.create!(data)

        headers = { "CONTENT_TYPE" => "application/json" }

        data = {
          origin: "Denver,CO",
          destination: "Pueblo,CO",
          api_key: user.api_key
        }

        post '/api/v1/road_trip', params: data

        expect(response.status).to eq(200)

        data = JSON.parse(response.body, symbolize_names: true)
        binding.pry
      end
    end
  end
end