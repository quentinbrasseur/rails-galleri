class UpdateForeignKey < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :appointments, :artworks
    add_foreign_key :appointments, :artworks, on_delete: :cascade
  end
end
