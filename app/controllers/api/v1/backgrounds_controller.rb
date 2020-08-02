class Api::V1::BackgroundsController < ApplicationController

  def index
    background_results = BackgroundResults.new
    background = background_results.background_image(params[:location])
    render json: BackgroundSerializer.new(background)
  end
end
