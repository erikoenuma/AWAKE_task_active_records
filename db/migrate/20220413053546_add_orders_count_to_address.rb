class AddOrdersCountToAddress < ActiveRecord::Migration[6.0]
  def change
    add_column :addresses, :orders_count, :integer
  end
end
