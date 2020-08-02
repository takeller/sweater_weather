class CreateBackgrounds < ActiveRecord::Migration[6.0]
  def change
    create_table :backgrounds do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
