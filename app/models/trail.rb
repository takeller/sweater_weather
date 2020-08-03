class Trail < ApplicationRecord
  serialize :forecast, JSON
  serialize :trails, JSON
end
