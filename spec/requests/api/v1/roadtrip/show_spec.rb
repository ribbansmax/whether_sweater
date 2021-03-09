require 'rails_helper'

describe "Makes a road trip" do
  describe "happy path" do
    it "should sign in a user" do
      data = {
        email: 'email@example.com',
        password: 'Password',
        password_confirmation: 'Password'
      }

      user = User.create!(data)

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/road_trip', params: data

      expect(response.status).to eq(200)

    end
  end
end