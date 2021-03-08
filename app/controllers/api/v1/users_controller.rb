class Api::V1::UsersController < ApplicationController

  def create
    # begin
      # if request.content_type != 'application/json'
      #   render json: {"error" => 'bad content-type'}, status: 400
      # else
        user = User.new(user_params)
        if user.valid?
          user.save
          render json: UserSerializer.new(user), status: 201
        else  
          render json: {"error" => 'invalid signup'}, status: 400
        end
    #   end
    # rescue
      
    # end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end