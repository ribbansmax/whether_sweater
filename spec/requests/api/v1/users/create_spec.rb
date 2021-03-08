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
      post '/api/v1/users', params: data

      expect(response.status).to eq(200)
      expect(User.last.email).to eq(data[:email])
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
      post '/api/v1/users', params: data

      expect(response.status).to eq(400)
    end

    it 'should not create a user if their password does not match the confirmation' do
      data = {
        email: 'email@example.com',
        password: 'Password',
        password_confirmation: 'password'
      }
      headers = { "CONTENT_TYPE" => "application/json" }
      post '/api/v1/users', params: data

      expect(response.status).to eq(400)
    end
  end
end