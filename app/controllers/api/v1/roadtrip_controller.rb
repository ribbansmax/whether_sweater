class Api::V1::RoadtripController < ApplicationController
  rescue_from RuntimeError, with: :sad_route

  def show
    return invalid_key unless User.find_by(api_key: params[:api_key])

    destination = MapQuestFacade.get_destination(params[:origin], params[:destination])
    fforecast = ForecastFacade.get_future_forecast(destination)
    roadtrip = Roadtrip.new(params, destination, fforecast)
    render json: RoadtripSerializer.new(roadtrip)
  end

  protected

  def invalid_key
    render json: { 'error' => 'api_key is invalid' }, status: 401
  end

  def sad_route(ex)
    render json: { 'error' => 'impossible route' }, status: 400 if ex.message == 'impossible'
    render json: { 'error' => 'mapquest is down' }, status: 400 if ex.message == 'bad mapquest'
  end
end
