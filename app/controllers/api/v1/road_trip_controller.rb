class Api::V1::RoadTripController < ApplicationController

  def index
    api_key = road_trip_params[:api_key]
    if valid_key?(api_key) == false
      render json: "Invalid credentials", status: 401
    elsif valid_locations? == false
      render json: "Invalid location", status: 400
    elsif User.find_by(api_key: api_key)
      road_trip_results = RoadTripResults.new
      road_trip = road_trip_results.road_trip(road_trip_params.except(:api_key))
      render json: RoadTripSerializer.new(road_trip)
    end
  end

  private

  def road_trip_params
    JSON.parse(request.body.read, symbolize_names: true)
  end

  def valid_locations?
    return false if road_trip_params[:origin].present? == false
    return false if road_trip_params[:destination].present? == false

    true
  end

  def valid_key?(api_key)
    return false if api_key.nil?
    return false if User.find_by(api_key: api_key).nil?

    true
  end
end
