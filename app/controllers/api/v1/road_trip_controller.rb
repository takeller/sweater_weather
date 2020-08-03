class Api::V1::RoadTripController < ApplicationController

  def index
    api_key = road_trip_params[:api_key]
    if api_key.nil?
      render json: "Missing API Key", status: 401
    elsif road_trip_params[:origin].present? == false
      render json: "Missing origin location", status: 400
    elsif road_trip_params[:destination].present? == false
      render json: "Missing destination location", status: 400
    elsif User.find_by(api_key: api_key).nil?
      render json: "Invalid API Key", status: 401
    elsif User.find_by(api_key: api_key)
      road_trip_results = RoadTripResults.new
      road_trip = road_trip_results.road_trip(road_trip_params.except(:api_key))
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: "Bad Request", status: 400
    end
  end

  private

  def road_trip_params
    JSON.parse(request.body.read, symbolize_names: true)
  end
end
