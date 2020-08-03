class RoadTrip < ApplicationRecord
  serialize :forecast, JSON
end
