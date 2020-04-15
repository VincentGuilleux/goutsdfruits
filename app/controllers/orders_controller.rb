class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def prepare

  end

  def deliver

  end
end
