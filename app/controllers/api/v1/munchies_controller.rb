class Api::V1::MunchiesController < ApplicationController
  def show
    destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    forecast = ForecastFacade.get_forecast(destination) # borrowed previously created route
    restaurant = RestaurantFacade.get_restaurant(destination, params[:food])

    munchie = Munchie.new(destination, forecast, restaurant, params[:destination])

    render json: MunchieSerializer.new(munchie)

  end
end