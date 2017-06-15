class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.references :product, foreign_key: true, index: true, null: false
      t.references :tag, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
