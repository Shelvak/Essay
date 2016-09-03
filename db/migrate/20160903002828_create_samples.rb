class CreateSamples < ActiveRecord::Migration[5.0]
  def change
    create_table :samples do |t|
      t.string :element, null: false
      t.integer :quantity, default: 0
      t.references :essay, foreign_key: true

      t.timestamps
    end
  end
end
