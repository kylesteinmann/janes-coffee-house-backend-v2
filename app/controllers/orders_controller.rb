class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]

  
  # POST /orders
  def create
    @order = Order.new(order_params)

    result = client.checkout.create_payment_link(
        body: {
          idempotency_key: "{123426789}",
          order: {
            location_id: "{LFREXCP0TQ4VT}",
            line_items: [
              {
                order: @order.order,
              }
            ]
          }
        }
      )
      
      if result.success?
        puts result.data
      elsif result.error?
        warn result.errors
      end


    
    # if @order.save
    #   render json: @order, status: :created, location: @order
    # else
    #   render json: @order.errors, status: :unprocessable_entity
    # end
  end

  
end
