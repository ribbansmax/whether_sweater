class Api::V1::MunchiesController < ApplicationController
  def show
    # begin
    destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    # rescue
    current_weather = ForecastFacade.get_forecast(destination).current_weather
    # end
    binding.pry

  end
end