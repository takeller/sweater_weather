class Api::V1::RoadTripController < ApplicationController

  def index
    api_key = params[:road_trip][:api_key]
    if api_key.nil?
      render json: "Missing API Key", status: 401
    elsif params[:road_trip][:origin].present? == false
      render json: "Missing origin location", status: 400
    elsif params[:road_trip][:destination].present? == false
      render json: "Missing destination location", status: 400
    elsif User.find_by(api_key: api_key).nil?
      render json: "Invalid API Key", status: 401
    elsif User.find_by(api_key: api_key)
      road_trip_results = RoadTripResults.new
      road_trip = road_trip_results.road_trip(params[:road_trip].except(:api_key))
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: "Bad Request", status: 400
    end
  end
end
