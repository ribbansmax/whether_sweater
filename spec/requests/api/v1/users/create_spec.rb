require 'rails_helper'

describe "Creates a user" do
  describe "happy path" do
    it "should create a user" do
      data = {
        email: 'email@example.com',
        password: 'Password',
        password_confirmation: 'Password'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(201)
      expect(User.last.email).to eq(data[:email])
      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data[:id]).to eq(User.last.id.to_s)
      expect(data[:attributes][:email]).to eq(User.last.email)
      expect(data[:attributes][:api_key]).to eq(User.last.api_key)
    end
  end

  describe 'sad' do
    it "should not create a user if email already exists" do
      User.create!(:email => 'email@example.com', password: 'password', password_confirmation: 'password')

      expect(User.last.email).to eq('email@example.com')

      data = {
        email: 'email@example.com',
        password: 'Password',
        password_confirmation: 'Password'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq('Validation failed: Email has already been taken')
    end

    it 'should not create a user if their password does not match the confirmation' do
      data = {
        email: 'email@example.com',
        password: 'Password',
        password_confirmation: 'password'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/users', params: JSON.generate(data), headers: headers

      expect(response.status).to eq(400)
      expect(response.status).to eq(400)
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:error]).to eq("Validation failed: Password confirmation doesn't match Password")
    end
  end
end