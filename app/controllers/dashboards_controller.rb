class DashboardsController < ApplicationController
  def show
    @orders = Order.all
  end

  def prepare

  end

  def deliver

  end
end
