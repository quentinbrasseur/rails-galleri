class AddEndRequestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :end_request, :string
  end
end
