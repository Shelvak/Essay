class AddClientToEssays < ActiveRecord::Migration[5.0]
  def change
    add_reference :essays, :client, foreign_key: true
  end
end
