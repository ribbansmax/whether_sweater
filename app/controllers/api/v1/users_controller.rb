class Api::V1::UsersController < ApplicationController

  def create
    begin
      if request.content_type != 'application/json'
        render json: {"error" => 'bad content-type'}, status: 400
      else
        if !check_passwords(params)
          render json: {"error" => 'passwords must match, and be nonempty'}
        else
          if !check_email(params['user']['email'])
          render json: {"error" => 'email is already registered'}
          else
            user = User.create!(user_params(params))
          end
        end
      end
    rescue
      
    end
  end

  private

  def user_params(params)
    params.require('user').permit('email', 'password', 'password_confirmation')
  end

  def check_passwords(params)
    user = params['user']
    user['password'] == user['password_confirmation'] && 
      (user['password'] || user['email']) != nil
  end

  def check_email(email)
    !User.find_by(email: email)
  end
end