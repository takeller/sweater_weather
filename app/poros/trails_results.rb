class TrailsResults

  def initialize
    @forecast_results ||= ForecastResults.new
    @map_quest_service ||= MapQuestService.new
    # @hiking_project_service ||= HikingProjectService.new
  end

  def trails(location)
    forecast = @forecast_results.forecast(location)
    current_forecast = format_forecast(forecast[:current])
    location = forecast[:location]['location']
    Trail.new(location: location, forecast: current_forecast)
  end

  private
  def format_forecast(forecast)
    {
      summary: forecast['weather'],
      temperature: forecast['temp']
    }
  end
end
