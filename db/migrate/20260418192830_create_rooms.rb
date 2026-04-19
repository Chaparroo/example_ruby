class CreateRooms < ActiveRecord::Migration[8.1]
  def change
    create_table :rooms do |t|
      t.references :hotel, null: false, foreign_key: true
      t.references :room_type, null: false, foreign_key: true
      t.string :number
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
