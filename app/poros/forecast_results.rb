class ForecastResults

  def initialize
    @open_weather_service ||= OpenWeatherService.new
    @map_quest_service ||= MapQuestService.new
  end

  def forecast(location)
    lat_long = get_lat_long(location)
    get_forecast(lat_long)
  end

private
  def get_lat_long(location)
    response = @map_quest_service.geocode(location)
    response[:results][0][:locations][0][:latLng]
  end

  def get_forecast(lat_long)
    response = @open_weather_service.forecast(lat_long)
    current = response[:current]
    hourly = response[:hourly]
    daily = response[:daily]
  end
end
