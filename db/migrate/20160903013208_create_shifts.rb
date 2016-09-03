class CreateShifts < ActiveRecord::Migration[5.0]
  def change
    create_table :shifts do |t|
      t.datetime :start_at
      t.datetime :finish_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
