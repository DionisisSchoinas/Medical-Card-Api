class CreateDoctors < ActiveRecord::Migration[6.1]
  def change
    create_table :doctors do |t|
      t.string :speciality
      t.string :office_address
      t.string :phone
      t.string :email
      t.float :cost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
