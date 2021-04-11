class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images do |t|
      t.string :image_base64
      t.references :doctor, null: true, foreign_key: true

      t.timestamps
    end
  end
end
