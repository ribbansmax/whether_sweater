require 'rails_helper'

describe "Creates a user" do
  describe "happy path" do
    it "should create a user" do
      data = {
        'email' => 'email@example.com',
        'password' => 'Password',
        'password_confirmation' => 'Password'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/users', params: data, as: :json

      binding.pry
      expect(response.status).to eq(200)
      expect(User.last.email).to eq(data['email'])
    end
  end
end