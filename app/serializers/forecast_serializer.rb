class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :current, :hourly, :daily

  attribute :id do |forecast|
    "1"
  end
end
