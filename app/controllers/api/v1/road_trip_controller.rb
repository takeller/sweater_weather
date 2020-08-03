class Api::V1::RoadTripController < ApplicationController

  def index
    road_trip_results = RoadTripResults.new
    road_trip = road_trip_results.road_trip(params[:road_trip].except(:api_key))
    render json: RoadTripSerializer.new(road_trip)
  end
end
