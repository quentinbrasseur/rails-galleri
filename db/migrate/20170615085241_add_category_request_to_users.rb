class AddCategoryRequestToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :category_request, :string
  end
end
