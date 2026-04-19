class CreateHotels < ActiveRecord::Migration[8.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :country
      t.text :description

      t.timestamps
    end
  end
end
