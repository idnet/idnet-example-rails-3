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
    if @order.save!
      redirect_to proceed_order_path(@order)
    else
      render :new
    end
  end

  def proceed
    @order = Order.find params[:id]
  end

  def callback
    @order = Order.find(params[:transaction_id])
    if @order.callback_verified?(order_params.merge(_hmac: params[:hmac]).with_indifferent_access)
      @order.status = params[:status]
      @order.transaction_unique_id = params[:transaction_unique_id]
      @order.save!
      redirect_to @order, success:  "Order was updated successfully"
    else
      redirect_to @order, alert:  "Callback parameters cannot be verified"
    end
  end

end
