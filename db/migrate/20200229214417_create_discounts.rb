class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :quantity
      t.decimal :percentage_off, precision: 3, scale: 2
      t.references :merchant, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
