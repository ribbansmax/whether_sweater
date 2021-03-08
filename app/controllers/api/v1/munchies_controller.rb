class Api::V1::MunchiesController < ApplicationController
  def show
    begin
      destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    rescue

    end
    begin
      forecast = ForecastFacade.get_forecast(destination) # borrowed previously created route
    rescue

    end
    begin
      restaurant = RestaurantFacade.get_restaurant(destination, params[:food])
    rescue
    else
      munchie = Munchie.new(destination, forecast, restaurant, params[:destination])
      render json: MunchieSerializer.new(munchie)
    end
  end
end