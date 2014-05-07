class OrdersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find params[:id]
  end

  def new
    @order = Order.new
    @order.user_id = current_user.id
  end

  def create
    @order = Order.new(params[:order])
    @order.user_id = current_user.id
    if @order.save
      redirect_to proceed_order_path(@order)
    else
      render :new
    end
  end

  def proceed
    @order = Order.find params[:id]
  end
end
