class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :show_error

  def create
    user = User.new(user_params)
    user.save!
    render json: UserSerializer.new(user), status: 201
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  protected

  def show_error(exception)
    render json: { error: exception.message }, status: 400
  end
end