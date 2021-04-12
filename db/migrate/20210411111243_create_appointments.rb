class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.integer :appointment_date_time_start
      t.integer :appointment_date_time_end

      t.timestamps
    end
  end
end
