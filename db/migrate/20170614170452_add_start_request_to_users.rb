class AddStartRequestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :start_request, :string
  end
end
