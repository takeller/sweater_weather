class ForecastResults
  include ForecastFormatter

  def initialize
    @open_weather_service ||= OpenWeatherService.new
    @map_quest_service ||= MapQuestService.new
  end

  def forecast(location)
    geocoded_location = geocode(location)
    raw_forecast = get_forecast(geocoded_location[:lat_long])
    formatted_forecast = format_forecast(raw_forecast, geocoded_location)
    Forecast.new(formatted_forecast)
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
    @open_weather_service.forecast(lat_long)
  end

  def format_forecast(raw_forecast, location)
    {
      location: location,
      current: current(raw_forecast),
      hourly: hourly(raw_forecast)[0..7],
      daily: daily(raw_forecast)
    }
  end
end
