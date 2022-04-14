class AddFoodsPriceSumToCustomer < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :foods_price_sum, :integer
  end
end
