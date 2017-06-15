class AddLocationRequestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :location_request, :string
  end
end
