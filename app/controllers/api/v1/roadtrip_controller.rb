class Api::V1::RoadtripController < ApplicationController
  rescue_from RuntimeError, with: :impossible_route

  def show
    return invalid_key if !User.find_by(api_key: params[:api_key])
    destination = MapQuestFacade.get_destination(params[:origin], params[:destination])
    fforecast = ForecastFacade.get_future_forecast(destination)
    roadtrip = Roadtrip.new(params, destination, fforecast)
    render json: RoadtripSerializer.new(roadtrip)
  end

  protected

  def invalid_key
    render json: {"error" => 'api_key is invalid'}, status: 401
  end

  def impossible_route
    render json: {"error" => 'impossible route'}, status: 400
  end
end