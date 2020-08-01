class Forecast

  attr_reader :current, :hourly, :daily

  def initialize(raw_forecast)
    @current = current(raw_forecast)
    @hourly = hourly(raw_forecast)
    @daily = daily(raw_forecast)
  end

  def current(raw_forecast)
    {
      weather: raw_forecast[:current][:weather][0][:description],
      time: raw_forecast[:current][:dt],
      temp: raw_forecast[:current][:temp],
      sunrise: raw_forecast[:current][:sunrise],
      sunset: raw_forecast[:current][:sunset],
      feels_like: raw_forecast[:current][:feels_like],
      humidity: raw_forecast[:current][:humidity],
      visibility: raw_forecast[:current][:visibility],
      uvi: raw_forecast[:current][:uvi]
    }
  end

  def hourly(raw_forecast)
    raw_forecast[:hourly]
  end

  def daily(raw_forecast)
    raw_forecast[:daily]
  end
end
