class CreateTrails < ActiveRecord::Migration[6.0]
  def change
    create_table :trails do |t|
      t.string :location
      t.string :forecast
      t.string :trails

      t.timestamps
    end
  end
end
