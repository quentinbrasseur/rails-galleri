class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :user, foreign_key: true
      t.references :artwork, foreign_key: true

      t.timestamps
    end
  end
end
