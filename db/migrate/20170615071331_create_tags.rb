class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title, index: true, null: false

      t.timestamps
    end
  end
end
