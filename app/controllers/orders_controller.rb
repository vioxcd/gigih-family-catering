class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]

  protect_from_forgery with: :null_session
  
  # GET /orders or /orders.json
  def index
    
    @orders = Order
    .filter_by_email(params[:email])
    .filter_by_min_total_price(params[:min_price])
    .filter_by_max_total_price(params[:max_price])
    .filter_by_start_date(params[:start_date])
    .filter_by_end_date(params[:end_date])
    
    render json: @orders.to_json(:include => :order_details) 
  end

  # GET /orders/1 or /orders/1.json
  def show
    render json: @order.to_json(:include => :order_details)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders or /orders.json
  def create
    calculate_total_price
    
    @order = Order.new(order_params)

    if @order.save
      render json: @order.to_json(:include => :order_details) 
    else
      render json: @order.errors, status: :unprocessable_entity 
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    status = params[:order][:status]
    
    unless ["NEW", "PAID", "CANCELED"].include? status
      render json: { message: " invalid enum status" }, status: :bad_request
      return
    end
    
    @order.delete_associate_order_details
    
    calculate_total_price

    if @order.update(order_params)
      render json: @order.to_json(:include => :order_details)
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy
    render json: { message: 'Order was successfully destroyed.' } 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      begin  
        @order = Order.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Order not found' }, status: :not_found
      end
    end

    def order_params
      params.require(:order).permit(:order_date, :total_price, :customer_name, :customer_email, :status, order_details_attributes: %i[id menu_item_id order_id name price quantity _destroy])
    end

    def calculate_total_price
      total_price = params[:order][:order_details_attributes].map { |order_detail| 
        menu_item = MenuItem.find(order_detail[:menu_item_id])
        order_detail[:price] = menu_item.price
        order_detail[:quantity].to_i * order_detail[:price] 
      }.sum
      
      params[:order][:total_price] = total_price
    end
end
