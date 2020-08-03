class TrailsResults

  def initialize
    @forecast_results ||= ForecastResults.new
    @map_quest_service ||= MapQuestService.new
    @hiking_project_service ||= HikingProjectService.new
  end

  def trails(location)
    trail_attributes = get_trail_attributes(location)
    Trail.new(trail_attributes)
  end

  private

  def get_trail_attributes(location)
    forecast = get_forecast(location)
    {
      forecast: forecast[:forecast],
      location: forecast[:start_location],
      trails: get_trail_details(forecast[:start_coordinates])
    }
  end

  def get_trail_details(start_coordinates)
    trail_details = @hiking_project_service.trails(start_coordinates)
    format_trail_details(trail_details[:trails], start_coordinates)
  end

  def get_forecast(location)
    forecast = @forecast_results.forecast(location)
    {
      start_coordinates: forecast[:location]['lat_long'],
      start_location: forecast[:location]['location'],
      forecast: format_forecast(forecast[:current])
    }
  end

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
