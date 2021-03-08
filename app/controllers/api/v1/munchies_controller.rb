class Api::V1::MunchiesController < ApplicationController
  def show
    # begin
    destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    # rescue
    forecast = ForecastFacade.get_forecast(destination)
    # end
    restaurant = RestaurantFacade.get_restaurant(destination, params[:food])

    munchie = Munchie.new(destination, forecast, restaurant, params[:destination])

    render json: MunchieSerializer.new(munchie)

  end
end