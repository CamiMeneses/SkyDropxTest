class CreateShipments < ActiveRecord::Migration[6.0]
  def change
    create_table :shipments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :carrier
      t.string :tracking_number
      t.string :status
      t.string :description

      t.timestamps
    end
  end
end
