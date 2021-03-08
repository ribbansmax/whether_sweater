class Api::V1::MunchiesController < ApplicationController
  def show
    begin
      destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    rescue
      render json: {"error" => 'route error'}, status: 400
    else
      begin
        forecast = ForecastFacade.get_forecast(destination) # borrowed previously created route
      rescue
        render json: {"error" => 'forecast error'}
      else
        begin
          restaurant = RestaurantFacade.get_restaurant(destination, params[:food])
        rescue
          render json: {"error" => 'yelp error, no restaurant found'}, status: 404
        else
          munchie = Munchie.new(destination, forecast, restaurant, params[:destination])
          render json: MunchieSerializer.new(munchie)
        end
      end
    end
  end
end