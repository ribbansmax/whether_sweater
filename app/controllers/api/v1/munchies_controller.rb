class Api::V1::MunchiesController < ApplicationController
  def show
    # begin
    destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    # rescue
    current_weather = ForecastFacade.get_forecast(destination).current_weather
    # end
    restaurant = RestaurantFacade.get_restaurant(destination, params[:food])

  end
end