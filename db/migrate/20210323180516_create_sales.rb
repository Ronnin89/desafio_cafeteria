class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :drink, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
