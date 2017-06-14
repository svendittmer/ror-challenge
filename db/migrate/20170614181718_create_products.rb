class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, index: true, null: false
      t.monetize :price, currency: { present: false }, amount: { default: nil }

      t.timestamps
    end
  end
end
