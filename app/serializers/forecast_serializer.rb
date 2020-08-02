class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current, :hourly, :daily
end
