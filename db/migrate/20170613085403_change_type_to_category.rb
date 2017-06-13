class ChangeTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    rename_column :artworks, :type, :category
  end
end
