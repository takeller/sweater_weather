class TrailsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :forecast, :trails
end
