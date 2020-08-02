class CreateForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :forecasts do |t|
      t.string :location
      t.string :current
      t.string :hourly
      t.string :daily

      t.timestamps
    end
  end
end
