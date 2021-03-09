require 'rails_helper'

describe "Signs in a user" do
  describe "happy path" do
    it "should sign in a user" do
      data = {
        email: 'email@example.com',
        password: 'Password'
      }

      user = User.create(data.merge(password_confirmation: 'Password'))

      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/sessions', params: data

      expect(response.status).to eq(200)
      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to eq(user.id.to_s)
      expect(data[:attributes][:email]).to eq(user.email)
      expect(data[:attributes][:api_key]).to eq(user.api_key)
    end
  end
end