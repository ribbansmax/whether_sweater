class Api::V1::UsersController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :show_error

  def create
    # begin
      # if request.content_type != 'application/json'
      #   render json: {"error" => 'bad content-type'}, status: 400
      # else
        user = User.new(user_params)
        # begin
          user.save!
          render json: UserSerializer.new(user), status: 201
        # rescue
          # binding.pry 
          # render json: {"error" => 'invalid signup'}, status: 400
        # end
    #   end
    # rescue
      
    # end
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