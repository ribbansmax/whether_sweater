require 'rails_helper'

describe "Makes a road trip" do
  describe "happy path" do
    it "should accept a users api key and return a trip" do
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

        data = JSON.parse(response.body, symbolize_names: true)[:data]

        expect(data[:type]).to eq('roadtrip')
        expect(data[:attributes][:start_city]).to eq('Denver, CO')
        expect(data[:attributes][:end_city]).to eq('Pueblo, CO')
        expect(data[:attributes][:travel_time]).to eq('1 hours 44 min')
        expect(data[:attributes][:weather_at_eta]).to eq({:temperature=>49.48, :conditions=>"clear sky"})
      end
    end
  end
  describe "sad path" do
    it "should not accept an invalid api key and return a 401" do
      VCR.use_cassette('no_roadtrip_to_pueblo') do
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
          api_key: '3'
        }

        post '/api/v1/road_trip', params: data

        expect(response.status).to eq(401)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('api_key is invalid')
      end
    end
    it "should no accept an invalid api key and return a 401" do
      VCR.use_cassette('no_roadtrip_to_the_moon') do
        data = {
          email: 'email@example.com',
          password: 'Password',
          password_confirmation: 'Password'
        }

        user = User.create!(data)

        headers = { "CONTENT_TYPE" => "application/json" }

        data = {
          origin: "Denver,CO",
          destination: "Moscow, Russia",
          api_key: user.api_key
        }

        post '/api/v1/road_trip', params: data

        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)

        expect(data[:error]).to eq('impossible route')
      end
    end
  end
end