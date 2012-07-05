class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    params[:search] ||= {}

    if params[:search][:client].present?
      @client = Client.find params[:search][:client]
      if params[:search][:po_number].present?
        @client = @client.orders.find params[:search][:po_number]
      end
      @order_lines = @client.order_lines
    else
      if params[:search][:po_number].present?
        @order = Order.find params[:search][:po_number]
        @order_lines = @order.order_lines
      else
        @order_lines = OrderLine
      end
    end

    search = params[:search].slice *OrderLine.column_names
    search.select! {|k, v| v.present? }
    if search.present?
      @order_lines = @order_lines.where(search)
    end

    @order_lines = @order_lines.order(sort_by_field).page(params[:page]).per_page(20)

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
end
