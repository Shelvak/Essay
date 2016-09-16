class AddCommentsToEssays < ActiveRecord::Migration[5.0]
  def change
    add_column :essays, :comments, :text
  end
end
