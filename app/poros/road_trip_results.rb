class RoadTripResults

  def initialize
    @forecast_results ||= ForecastResults.new
    @map_quest_service ||= MapQuestService.new
  end

  def road_trip(road_trip_params)
    road_trip_attributes = get_road_trip_attributes(road_trip_params)
    RoadTrip.new(road_trip_attributes)
  end

  private

  def get_road_trip_attributes(road_trip_params)
    forecast = @forecast_results.forecast(road_trip_params[:destination])
    travel_time = find_travel_time(road_trip_params)
    {
      origin: road_trip_params[:origin],
      destination: road_trip_params[:destination],
      travel_time: travel_time,
      forecast: format_forecast(forecast)
    }
  end

  def format_forecast(forecast)
    {
      temp: forecast[:current]['temp'],
      weather: forecast[:current]['weather']
    }
  end

  def find_travel_time(road_trip_params)
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    directions = @map_quest_service.directions(origin, destination)
    minutes = directions[:route][:realTime]/60
    "#{minutes / 60}:#{minutes % 60}"
  end
end
