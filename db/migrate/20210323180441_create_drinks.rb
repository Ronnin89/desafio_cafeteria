class CreateDrinks < ActiveRecord::Migration[5.2]
  def change
    create_table :drinks do |t|
      t.integer :price
      t.string :origin
      t.string :blend_name

      t.timestamps
    end
  end
end
