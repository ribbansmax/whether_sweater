class Api::V1::SessionsController < ApplicationController
  def show
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.new(user)
    else
      render json: { 'error' => 'Email and password do not match a user in our database' }, status: 401
    end
  end
end
