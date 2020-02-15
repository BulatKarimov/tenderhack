class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.string :manufacturer_country
      t.string :product_type
      t.float :length
      t.float :width
      t.float :height
      t.string :material
      t.float :diameter
      t.string :string
      t.string :color
      t.float :weight
      t.float :volume
      t.float :amount

      t.timestamps
    end
  end
end
