module ForecastFormatter
  def current(raw_forecast)
    {
      weather: raw_forecast[:current][:weather][0][:description],
      time: Time.at(raw_forecast[:current][:dt]).strftime('%l:%M %p, %B%e'),
      temp: raw_forecast[:current][:temp].round,
      sunrise: Time.at(raw_forecast[:current][:sunrise]).strftime('%l:%M %p'),
      sunset: Time.at(raw_forecast[:current][:sunset]).strftime('%l:%M %p'),
      feels_like: raw_forecast[:current][:feels_like].round,
      humidity: raw_forecast[:current][:humidity],
      visibility: raw_forecast[:current][:visibility] * 0.000621371,
      uvi: raw_forecast[:current][:uvi],
      icon: get_icon_image(raw_forecast[:current][:weather][0][:icon])
    }
  end

  def hourly(raw_forecast)
    raw_forecast[:hourly].map do |hourly_forecast|
      {
        time: Time.at(hourly_forecast[:dt]).strftime('%l%p'),
        temp: hourly_forecast[:temp].round,
        weather: hourly_forecast[:weather][0][:description],
        icon: get_icon_image(hourly_forecast[:weather][0][:icon])
      }
    end[0..7]
  end

  def daily(raw_forecast)
    raw_forecast[:daily].map do |daily_forecast|
      {
        day: Time.at(daily_forecast[:dt]).strftime('%A'),
        weather: daily_forecast[:weather][0][:main],
        icon: get_icon_image(daily_forecast[:weather][0][:icon]),
        precipitation: precipitation(daily_forecast),
        high: daily_forecast[:temp][:max].round,
        low: daily_forecast[:temp][:min].round
      }
    end
  end

  private

  def precipitation(daily_forecast)
    if daily_forecast[:rain]
      daily_forecast[:rain]
    elsif daily_forecast[:snow]
      daily_forecast[:snow]
    else
      0
    end
  end

  def get_icon_image(icon_code)
    "http://openweathermap.org/img/wn/#{icon_code}@2x.png"
  end
end
