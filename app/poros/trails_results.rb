class TrailsResults

  def initialize
    @forecast_results ||= ForecastResults.new
    @map_quest_service ||= MapQuestService.new
    @hiking_project_service ||= HikingProjectService.new
  end

  def trails(location)
    forecast = @forecast_results.forecast(location)
    current_forecast = format_forecast(forecast[:current])
    location = forecast[:location]['location']
    trail_details = @hiking_project_service.trails(forecast[:location]['lat_long'])
    formatted_trail_details = format_trail_details(trail_details[:trails], forecast[:location]['lat_long'])
    Trail.new(location: location, forecast: current_forecast, trails: formatted_trail_details)
  end

  private
  def format_forecast(forecast)
    {
      summary: forecast['weather'],
      temperature: forecast['temp']
    }
  end

  def format_trail_details(trail_details, start_coordinates)
    trail_details.map do |trail|
      trail_lat_long = "#{trail[:latitude]},#{trail[:longitude]}"

      {
        name: trail[:name],
        summary: trail[:summary],
        difficulty: trail[:difficulty],
        location: trail[:location],
        distance_to_trail: find_distance(trail_lat_long, start_coordinates)
      }
    end
  end

  def find_distance(trail_coordinates, start_coordinates)
    start_coordinates = "#{start_coordinates['lat']},#{start_coordinates['lng']}"
    directions = @map_quest_service.directions(trail_coordinates, start_coordinates)
    directions[:route][:distance]
  end
end
