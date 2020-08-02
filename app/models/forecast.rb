class Forecast < ApplicationRecord
  serialize :location, JSON
  serialize :current, JSON
  serialize :daily, JSON
  serialize :hourly, JSON
end
