class CreateRoadTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :road_trips do |t|
      t.string :origin
      t.string :destination
      t.string :travel_time
      t.string :forecast

      t.timestamps
    end
  end
end
