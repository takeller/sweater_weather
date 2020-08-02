class Api::V1::BackgroundsController < ApplicationController

  def index
    background_results = BackgroundResults.new
    background_results.background_image(params[:location])
  end
end
