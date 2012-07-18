class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    params[:search] ||= {}
    params[:display] ||= {}

    if params[:display] == "shipped"
      list_per_page = 100
    else
      list_per_page = 500
    end

    @order_lines = OrderLine.search(
      :start_date => params[:search][:start_date],
      :end_date => params[:search][:end_date],
      :status_option => params[:search][:status_option],
      :shipped => params[:display] == "shipped",
      :client_id => params[:search][:client],
      :order_id => params[:search][:po_number],
      :search => params[:search].slice(*OrderLine.column_names).select{|k, v| v.present?},
      :sort => (sort_by_field || "created_at desc"),
      :page => params[:page],
      :per_page =>  list_per_page
    )

    if params[:controller] == "orders"
      cookies["order_line_sort_order"] = sort_by_field
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_lines }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to orders_path, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        Rails.logger.info @order.errors.inspect
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to orders_path, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  def update_search_dropdowns
    @clients = Client.order("LOWER(name)")
    @orders  = Order.order(:purchase_order)
    if params[:display] == "shipped"
      @orders = @orders.joins(:order_lines).where{order_lines.status == "shipped"}.group(:id)
    else
      @orders = @orders.joins(:order_lines).where{order_lines.status != "shipped"}.group(:id)
    end

    @parts  = Part.order(:part_number)

    if params[:client_id].present?
      @orders = @orders.where(:client_id => params[:client_id])
    end

    if params[:part_id].present?
      @orders = @orders.joins(:order_lines).where{order_lines.part_id == my{params[:part_id]}}.group(:id)
      @clients = @clients.joins(:orders => :order_lines).where{(order_lines.part_id == my{params[:part_id]})}.group(:id)
    end

    if params[:order_id].present?
      @parts = @parts.joins(:order_lines).where{order_lines.order_id == my{params[:order_id]}}
      @clients = @clients.joins(:orders).where(:"orders.id" => params[:order_id])
    end
  end
end
