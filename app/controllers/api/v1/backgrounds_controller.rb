class Api::V1::BackgroundsController < ApplicationController
  def show
    if params['location'] != ('' || nil)
      picture = PictureFacade.get_picture(params['location'])
      render json: ImageSerializer.new(picture)
    else
      render json: { 'error' => 'no location given' }, status: 400
    end
  rescue StandardError
    render json: { 'error' => 'no pictures match search' }, status: 404
  end
end
