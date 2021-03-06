class ExercisesController < ApplicationController
  def exercise1
    # 【要件】注文されていないすべての料理を返すこと
    #   * left_outer_joinsを使うこと
    @foods = Food.left_outer_joins(:order_foods).where(order_foods: {food_id: nil})
  end

  def exercise2
    # 【要件】注文されていない料理を提供しているすべてのお店を返すこと
    #   * left_outer_joinsを使うこと
    @shops = Shop.left_outer_joins(:foods).where(foods: { id: Food.left_outer_joins(:order_foods).where(order_foods: {food_id: nil}).ids}).distinct
  end

  def exercise3 
    # 【要件】配達先の一番多い住所を返すこと
    #   * joinsを使うこと
    #   * 取得したAddressのインスタンスにorders_countと呼びかけると注文の数を返すこと
    Address.all.each{ |address| 
      address.update(orders_count: Order.where(address_id: address.id).count || 0)
    }
    @address = Address.joins(:orders).where.not(orders: {address_id: nil}).order("orders_count DESC").first
  end

  def exercise4 
    # 【要件】一番お金を使っている顧客を返すこと
    #   * joinsを使うこと
    #   * 取得したCustomerのインスタンスにfoods_price_sumと呼びかけると合計金額を返すこと
    Customer.all.each{ |customer|
      customer.update(foods_price_sum: Order.joins(:foods).where(customer_id: customer.id).sum(:price))
    }
    @customer = Customer.joins(:orders).order("foods_price_sum DESC").first
  end
end
