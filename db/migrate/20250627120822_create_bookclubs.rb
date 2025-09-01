class CreateBookclubs < ActiveRecord::Migration[8.0]
  def change
    create_table :bookclubs do |t|
      t.string :name
      t.integer :noofmem

      t.timestamps
    end
  end
end
