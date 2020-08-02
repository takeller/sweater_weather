class OpenWeatherService
  include ServiceHelper

  def forecast(lat_long)
    get_json("/data/2.5/onecall", {lat: lat_long[:lat], lon: lat_long[:lng], exclude: 'minutely'})
  end

  private

  def conn
    Faraday.new(url: "https://api.openweathermap.org") do |faraday|
      faraday.params['appid'] = ENV['OPEN_WEATHER_KEY']
      faraday.params['units'] = "imperial"
    end
  end
end
