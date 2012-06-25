class OrderLinesController < ApplicationController
  # GET /order_lines
  # GET /order_lines.json
  def index
    @order_lines = OrderLine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_lines }
    end
  end

  # GET /order_lines/1
  # GET /order_lines/1.json
  def show
    @order_line = OrderLine.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_line }
    end
  end

  # GET /order_lines/new
  # GET /order_lines/new.json
  def new
    @order_line = OrderLine.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_line }
    end
  end

  # GET /order_lines/1/edit
  def edit
    @order_line = OrderLine.find(params[:id])
  end

  # POST /order_lines
  # POST /order_lines.json
  def create
    @order_line = OrderLine.new(params[:order_line])

    respond_to do |format|
      if @order_line.save
        format.html { redirect_to @order_line, notice: 'Order line was successfully created.' }
        format.json { render json: @order_line, status: :created, location: @order_line }
      else
        format.html { render action: "new" }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_lines/1
  # PUT /order_lines/1.json
  def update
    @order_line = OrderLine.find(params[:id])

    respond_to do |format|
      if @order_line.update_attributes(params[:order_line])
        format.html { redirect_to @order_line, notice: 'Order line was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @order_line.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_lines/1
  # DELETE /order_lines/1.json
  def destroy
    @order_line = OrderLine.find(params[:id])
    @order_line.destroy

    respond_to do |format|
      format.html { redirect_to order_lines_url }
      format.json { head :no_content }
    end
  end
end
