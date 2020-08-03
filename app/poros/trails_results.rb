class TrailsResults

  def initialize
    @forecast_results ||= ForecastResults.new
    @map_quest_service ||= MapQuestService.new
    @hiking_project_service ||= HikingProjectService.new
  end

  def trails(location)
    @forecast_results.forecast(location)
  end
end
