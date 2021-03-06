class Api::V1::MunchiesController < ApplicationController
  def show
    destination = MapQuestFacade.get_destination(params[:start], params[:destination])
  rescue StandardError
    render json: { 'error' => 'route error' }, status: 400
  else
    begin
      forecast = ForecastFacade.get_forecast(destination) # borrowed previously created route
    rescue StandardError
      render json: { 'error' => 'forecast error' }, status: 404
    else
      begin
        restaurant = RestaurantFacade.get_restaurant(destination, params[:food])
      rescue StandardError
        render json: { 'error' => 'yelp error, no restaurant found' }, status: 404
      else
        munchie = Munchie.new(destination, forecast, restaurant, params[:destination])
        render json: MunchieSerializer.new(munchie)
      end
    end
  end
end
