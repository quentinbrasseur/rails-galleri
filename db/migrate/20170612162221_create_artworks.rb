class CreateArtworks < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.string :type
      t.string :size
      t.string :location
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
