class AddNumCategoryToArtwork < ActiveRecord::Migration[5.0]
  def change
    add_column :artworks, :num_category, :integer
  end
end
