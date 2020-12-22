class AddNotNullToImages < ActiveRecord::Migration[5.2]
  def change
    change_column_null :images, :name, false
    change_column_null :images, :url, false
  end
end
