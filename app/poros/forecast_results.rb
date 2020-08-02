class ForecastResults

  def initialize
    @open_weather_service ||= OpenWeatherService.new
    @map_quest_service ||= MapQuestService.new
  end

  def forecast(location)
    geocoded_location = geocode(location)
    raw_forecast = get_forecast(geocoded_location[:lat_long])
    Forecast.new(raw_forecast, geocoded_location)
  end

private
  def geocode(location)
    response = @map_quest_service.geocode(location)
    {
      location: response[:results][0][:providedLocation][:location],
      country: response[:results][0][:locations][0][:adminArea1],
      lat_long: response[:results][0][:locations][0][:latLng]
    }
  end

  def get_forecast(lat_long)
    response = @open_weather_service.forecast(lat_long)
  end
end
