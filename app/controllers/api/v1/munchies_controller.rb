class Api::V1::MunchiesController < ApplicationController
  def show
    # begin
      destination = MapQuestFacade.get_destination(params[:start], params[:destination])
    # rescue

    # end
    binding.pry

  end
end