class Api::V1::TrailsController < ApplicationController

  def index
    trails_results = TrailsResults.new
    trails = trails_results.trails(params[:location])
    render json: TrailsSerializer.new(trails)
  end
end
