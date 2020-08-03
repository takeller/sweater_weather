class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :origin, :destination, :forecast, :travel_time
end
