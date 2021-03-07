class Api::V1::ForecastController < ApplicationController
  def show
    begin
      if params[:location] == ''
        render json: {"error" => 'no location given'}, status: 400
      else
        location = MapQuestFacade.get_lat_lon(params[:location])
        if (location.lat == 39.390897) && (location.lon == -99.066067)
          render json: {"error" => 'bad location'}, status: 404
        else
          forecast = ForecastFacade.get_forecast(location)
          render json: ForecastSerializer.new(forecast)
        end
      end
    rescue
      render json: {"error" => 'open-weather is down'}, status: 400
    end
  end
end